#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./run_checks.sh lvs [cell_name]

Examples:
  ./run_checks.sh lvs bgr_error_amp
  ./run_checks.sh lvs

Notes:
  - cell_name is given without .mag/.sch extension.
  - If cell_name is omitted, bgr is used.
  - Generated files are written under build/.
EOF
}

die() {
  echo "error: $*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
}

repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")" && pwd
}

run_lvs() {
  local cell="${1:-bgr}"
  local root magic_dir xschem_dir build_dir magic_file schem_file
  local magic_rc netgen_setup pdk_xschem_symbols
  local layout_spice raw_layout_spice schem_spice magic_tcl lvs_report xschem_work_dir

  root="$(repo_root)"
  magic_dir="$root/magic"
  xschem_dir="$root/xschem"
  build_dir="$root/build/lvs/$cell"

  magic_file="$magic_dir/$cell.mag"
  schem_file="$xschem_dir/$cell.sch"

  magic_rc="${MAGIC_RC:-${PDK_ROOT:-/foss/pdks}/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc}"
  netgen_setup="${NETGEN_SETUP:-${PDK_ROOT:-/foss/pdks}/gf180mcuD/libs.tech/netgen/gf180mcuD_setup.tcl}"
  pdk_xschem_symbols="${PDK_ROOT:-/foss/pdks}/gf180mcuD/libs.tech/xschem/symbols"

  layout_spice="$build_dir/${cell}_layout.spice"
  raw_layout_spice="$build_dir/${cell}.spice"
  schem_spice="$build_dir/${cell}.spice"
  magic_tcl="$build_dir/extract_${cell}.tcl"
  lvs_report="$build_dir/${cell}_lvs.out"
  xschem_work_dir="$build_dir/xschem_work"

  [[ -f "$magic_file" ]] || die "layout not found: $magic_file"
  [[ -f "$schem_file" ]] || die "schematic not found: $schem_file"
  [[ -f "$magic_rc" ]] || die "Magic rcfile not found: $magic_rc"
  [[ -f "$netgen_setup" ]] || die "Netgen setup not found: $netgen_setup"
  [[ -d "$pdk_xschem_symbols" ]] || die "Xschem PDK symbols not found: $pdk_xschem_symbols"

  require_cmd magic
  require_cmd xschem
  require_cmd netgen

  mkdir -p "$build_dir"

  cat >"$magic_tcl" <<EOF
drc off
load "$magic_file"
select top cell
extract path "$build_dir"
extract all
ext2spice lvs
ext2spice subcircuit top on
cd "$build_dir"
ext2spice
quit -noprompt
EOF

  echo "==> Extracting layout: $magic_file"
  rm -f "$raw_layout_spice" "$layout_spice"
  magic -dnull -noconsole -rcfile "$magic_rc" "$magic_tcl"
  [[ -f "$raw_layout_spice" ]] || die "magic did not create expected layout netlist: $raw_layout_spice"
  mv "$raw_layout_spice" "$layout_spice"

  echo "==> Netlisting schematic: $schem_file"
  # Xschem resolves relative symbols from its working directory.  Stage a
  # hierarchy view containing both the project cells and the GF180 symbols so
  # top-level cells can descend into local subcircuits without losing access to
  # references such as symbols/nfet_03v3.sym.
  rm -rf "$xschem_work_dir"
  mkdir -p "$xschem_work_dir"
  ln -s "$xschem_dir"/*.sch "$xschem_dir"/*.sym "$xschem_work_dir/"
  ln -s "$pdk_xschem_symbols" "$xschem_work_dir/symbols"
  (
    cd "$xschem_work_dir"
    xschem -q -n -r -x -o "$build_dir" --netlist "$cell.sch"
  )
  [[ -f "$schem_spice" ]] || die "xschem did not create expected netlist: $schem_spice"
  sed 's/^\*\*\.subckt/.subckt/; s/^\*\*\.ends/.ends/' "$schem_spice" >"$schem_spice.tmp"
  mv "$schem_spice.tmp" "$schem_spice"

  echo "==> Running LVS: layout=$cell schematic=$cell"
  netgen -batch lvs \
    "$layout_spice $cell" \
    "$schem_spice $cell" \
    "$netgen_setup" \
    "$lvs_report"

  [[ -f "$lvs_report" ]] || die "netgen did not create LVS report: $lvs_report"
  if grep -q "Netlists match uniquely" "$lvs_report"; then
    echo "==> LVS passed"
  else
    echo "==> LVS did not pass; see report: $lvs_report" >&2
    exit 1
  fi
  echo "==> LVS report: $lvs_report"
}

main() {
  local cmd="${1:-}"
  case "$cmd" in
    lvs)
      shift
      [[ $# -le 1 ]] || die "too many arguments for lvs"
      run_lvs "${1:-bgr}"
      ;;
    -h|--help|help|"")
      usage
      ;;
    *)
      die "unknown command: $cmd"
      ;;
  esac
}

main "$@"

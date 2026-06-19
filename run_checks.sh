#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./run_checks.sh {drc|antenna|lvs|pex|all} [cell_name]

Examples:
  ./run_checks.sh drc bgr
  ./run_checks.sh antenna bgr
  ./run_checks.sh lvs bgr_error_amp
  ./run_checks.sh pex bgr
  ./run_checks.sh all bgr
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

magic_rc() {
  echo "${MAGIC_RC:-${PDK_ROOT:-/foss/pdks}/gf180mcuD/libs.tech/magic/gf180mcuD.magicrc}"
}

require_magic_cell() {
  local cell="$1" root magic_file rcfile
  root="$(repo_root)"
  magic_file="$root/magic/$cell.mag"
  rcfile="$(magic_rc)"

  [[ -f "$magic_file" ]] || die "layout not found: $magic_file"
  [[ -f "$rcfile" ]] || die "Magic rcfile not found: $rcfile"
  require_cmd magic
}

run_drc() {
  local cell="${1:-bgr}" root magic_file build_dir magic_tcl report rcfile count
  root="$(repo_root)"
  magic_file="$root/magic/$cell.mag"
  build_dir="$root/build/drc/$cell"
  magic_tcl="$build_dir/drc_${cell}.tcl"
  report="$build_dir/${cell}_drc.out"
  rcfile="$(magic_rc)"

  require_magic_cell "$cell"
  mkdir -p "$build_dir"

  cat >"$magic_tcl" <<EOF
crashbackups stop
load "$magic_file"
select top cell
drc euclidean on
drc style drc(full)
drc check
drc catchup
set fout [open "$report" w]
set result [drc listall why]
set count 0
puts \$fout "cell: $cell"
foreach {why rectangles} \$result {
  puts \$fout "\n\$why"
  foreach rectangle \$rectangles {
    incr count
    puts \$fout "  \$rectangle"
  }
}
puts \$fout "\nDRC_COUNT=\$count"
close \$fout
quit -noprompt
EOF

  echo "==> Running full DRC: $magic_file"
  magic -dnull -noconsole -rcfile "$rcfile" "$magic_tcl"
  [[ -f "$report" ]] || die "Magic did not create DRC report: $report"
  count="$(sed -n 's/^DRC_COUNT=//p' "$report")"
  [[ "$count" =~ ^[0-9]+$ ]] || die "could not read DRC result from: $report"
  if (( count != 0 )); then
    echo "==> DRC failed with $count reported error area(s); see: $report" >&2
    return 1
  fi
  echo "==> DRC passed"
  echo "==> DRC report: $report"
}

run_antenna() {
  local cell="${1:-bgr}" root magic_file build_dir magic_tcl report feedback rcfile count
  root="$(repo_root)"
  magic_file="$root/magic/$cell.mag"
  build_dir="$root/build/antenna/$cell"
  magic_tcl="$build_dir/antenna_${cell}.tcl"
  report="$build_dir/${cell}_antenna.out"
  feedback="$build_dir/${cell}_antenna.feedback.tcl"
  rcfile="$(magic_rc)"

  require_magic_cell "$cell"
  mkdir -p "$build_dir"

  cat >"$magic_tcl" <<EOF
crashbackups stop
drc off
load "$magic_file"
select top cell
extract path "$build_dir"
extract all
cd "$build_dir"
feedback clear
antennacheck
set count [feedback count]
feedback save "$feedback"
set fout [open "$report" w]
puts \$fout "cell: $cell"
puts \$fout "ANTENNA_COUNT=\$count"
puts \$fout "feedback: $feedback"
close \$fout
quit -noprompt
EOF

  echo "==> Running GF180 antenna check: $magic_file"
  magic -dnull -noconsole -rcfile "$rcfile" "$magic_tcl"
  [[ -f "$report" ]] || die "Magic did not create antenna report: $report"
  count="$(sed -n 's/^ANTENNA_COUNT=//p' "$report")"
  [[ "$count" =~ ^[0-9]+$ ]] || die "could not read antenna result from: $report"
  if (( count != 0 )); then
    echo "==> Antenna check failed with $count violation(s); see: $report" >&2
    return 1
  fi
  echo "==> Antenna check passed"
  echo "==> Antenna report: $report"
}

run_pex() {
  local cell="${1:-bgr}" root magic_file build_dir magic_tcl rcfile
  local extract_cell raw_spice pex_spice report magic_log resistor_count capacitor_count
  root="$(repo_root)"
  magic_file="$root/magic/$cell.mag"
  build_dir="$root/build/pex/$cell"
  magic_tcl="$build_dir/pex_${cell}.tcl"
  rcfile="$(magic_rc)"
  extract_cell="${cell}_pex_flat"
  raw_spice="$build_dir/$extract_cell.spice"
  pex_spice="$build_dir/${cell}_pex.spice"
  report="$build_dir/${cell}_pex.out"
  magic_log="$build_dir/${cell}_pex.magic.log"

  require_magic_cell "$cell"
  mkdir -p "$build_dir"

  cat >"$magic_tcl" <<EOF
crashbackups stop
drc off
load "$magic_file"
flatten "$extract_cell"
load "$extract_cell"
select top cell
extract path "$build_dir"
extract do adjust
extract do capacitance
extract do coupling
extract do resistance
extract all
cd "$build_dir"
ext2sim labels on
ext2sim
extresist all
ext2spice default
ext2spice hierarchy off
ext2spice subcircuit top on
ext2spice scale off
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice
quit -noprompt
EOF

  echo "==> Extracting full R+C parasitics: $magic_file"
  rm -f "$raw_spice" "$pex_spice" "$report" "$magic_log"
  magic -dnull -noconsole -rcfile "$rcfile" "$magic_tcl" 2>&1 | tee "$magic_log"
  [[ -f "$raw_spice" ]] || die "Magic did not create expected PEX netlist: $raw_spice"
  if grep -Eq 'Cannot open file|Error in extracting node|Couldn.t find device|Missing substrate connection' "$magic_log"; then
    die "Magic reported incomplete resistance extraction; see: $magic_log"
  fi
  sed "s/^\\.subckt $extract_cell\\([[:space:]]\\)/.subckt $cell\\1/" "$raw_spice" >"$pex_spice"
  rm -f "$raw_spice"

  resistor_count="$(awk '/^[Rr][^[:space:]]*[[:space:]]/ {count++} END {print count+0}' "$pex_spice")"
  capacitor_count="$(awk '/^[Cc][^[:space:]]*[[:space:]]/ {count++} END {print count+0}' "$pex_spice")"
  cat >"$report" <<EOF
cell: $cell
netlist: $pex_spice
magic_log: $magic_log
PARASITIC_RESISTORS=$resistor_count
PARASITIC_CAPACITORS=$capacitor_count
EOF
  echo "==> PEX completed ($resistor_count resistors, $capacitor_count capacitors)"
  echo "==> PEX netlist: $pex_spice"
  echo "==> PEX report: $report"
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
    drc)
      shift
      [[ $# -le 1 ]] || die "too many arguments for drc"
      run_drc "${1:-bgr}"
      ;;
    antenna)
      shift
      [[ $# -le 1 ]] || die "too many arguments for antenna"
      run_antenna "${1:-bgr}"
      ;;
    lvs)
      shift
      [[ $# -le 1 ]] || die "too many arguments for lvs"
      run_lvs "${1:-bgr}"
      ;;
    pex)
      shift
      [[ $# -le 1 ]] || die "too many arguments for pex"
      run_pex "${1:-bgr}"
      ;;
    all)
      shift
      [[ $# -le 1 ]] || die "too many arguments for all"
      run_drc "${1:-bgr}"
      run_antenna "${1:-bgr}"
      run_lvs "${1:-bgr}"
      run_pex "${1:-bgr}"
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

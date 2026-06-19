#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./run_checks.sh {drc|drc-klayout|drc-all|antenna|lvs|pex|all} [cell_name]

Examples:
  ./run_checks.sh drc bgr
  ./run_checks.sh drc-klayout bgr
  ./run_checks.sh drc-all bgr
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

run_klayout_drc() {
  local cell="${1:-bgr}" root magic_file build_dir export_tcl gds_file
  local rcfile drc_runner variant run_log summary report count violation_count runner_rc details
  root="$(repo_root)"
  magic_file="$root/magic/$cell.mag"
  build_dir="$root/build/drc-klayout/$cell"
  export_tcl="$build_dir/export_${cell}_gds.tcl"
  gds_file="$build_dir/$cell.gds"
  run_log="$build_dir/${cell}_klayout_drc.log"
  summary="$build_dir/${cell}_klayout_drc.out"
  rcfile="$(magic_rc)"
  drc_runner="${KLAYOUT_DRC_RUNNER:-${PDK_ROOT:-/foss/pdks}/gf180mcuD/libs.tech/klayout/drc/run_drc.py}"
  variant="${KLAYOUT_DRC_VARIANT:-C}"

  require_magic_cell "$cell"
  require_cmd python3
  require_cmd klayout
  [[ -f "$drc_runner" ]] || die "KLayout GF180 DRC runner not found: $drc_runner"
  mkdir -p "$build_dir"

  cat >"$export_tcl" <<EOF
crashbackups stop
drc off
load "$magic_file"
select top cell
gds readonly true
gds rescale false
gds write "$gds_file"
quit -noprompt
EOF

  echo "==> Exporting GDS for KLayout DRC: $magic_file"
  rm -f "$gds_file" "$run_log" "$summary" "$build_dir"/*.lyrdb
  magic -dnull -noconsole -rcfile "$rcfile" "$export_tcl"
  [[ -f "$gds_file" ]] || die "Magic did not create GDS for KLayout DRC: $gds_file"

  echo "==> Running full KLayout GF180 DRC (variant $variant, FEOL+BEOL+connectivity+offgrid+density+antenna)"
  set +e
  python3 "$drc_runner" \
    --path="$gds_file" \
    --variant="$variant" \
    --topcell="$cell" \
    --run_dir="$build_dir" \
    --run_mode="${KLAYOUT_DRC_MODE:-flat}" \
    --mp="${KLAYOUT_DRC_JOBS:-2}" \
    --density \
    --antenna 2>&1 | tee "$run_log"
  runner_rc="${PIPESTATUS[0]}"
  set -e

  violation_count=0
  details=""
  while IFS= read -r report; do
    count="$(grep -c '<item>' "$report" || true)"
    violation_count=$((violation_count + count))
    details+="$(basename "$report"): $count"$'\n'
  done < <(find "$build_dir" -maxdepth 1 -type f -name '*.lyrdb' -print)

  if ! find "$build_dir" -maxdepth 1 -type f -name '*.lyrdb' -print -quit | grep -q .; then
    die "KLayout DRC produced no result databases; see: $run_log"
  fi

  cat >"$summary" <<EOF
cell: $cell
variant: $variant
gds: $gds_file
log: $run_log
runner_exit_code: $runner_rc
KLAYOUT_DRC_COUNT=$violation_count

$details
EOF
  if (( runner_rc != 0 && violation_count == 0 )); then
    echo "==> KLayout DRC tool failed without violation markers; see: $run_log" >&2
    return "$runner_rc"
  fi
  if (( violation_count != 0 )); then
    echo "==> KLayout DRC failed with $violation_count marker(s); see: $summary" >&2
    return 1
  fi
  echo "==> KLayout DRC passed"
  echo "==> KLayout DRC report: $summary"
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

PEX_CELL_ORDER=()

collect_pex_cells() {
  local cell="$1" root child existing
  root="$(repo_root)"
  while IFS= read -r child; do
    [[ -f "$root/magic/$child.mag" && -f "$root/xschem/$child.sch" ]] || continue
    collect_pex_cells "$child"
  done < <(awk '$1 == "use" {print $2}' "$root/magic/$cell.mag" | sort -u)

  for existing in "${PEX_CELL_ORDER[@]-}"; do
    [[ "$existing" == "$cell" ]] && return
  done
  PEX_CELL_ORDER+=("$cell")
}

run_pex() {
  local cell="${1:-bgr}" root build_dir rcfile report pex_spice raw_spice
  local stage stage_tcl stage_log assemble_tcl assemble_log
  local total extracted output failed=0 stage_details=""
  local bad_devices node_errors missing_connections
  local resistor_count capacitor_count
  root="$(repo_root)"
  build_dir="$root/build/pex/$cell"
  rcfile="$(magic_rc)"
  report="$build_dir/${cell}_pex.out"
  raw_spice="$build_dir/$cell.spice"
  pex_spice="$build_dir/${cell}_pex.spice"
  assemble_tcl="$build_dir/assemble_${cell}_pex.tcl"
  assemble_log="$build_dir/${cell}_pex_assemble.magic.log"

  require_magic_cell "$cell"
  mkdir -p "$build_dir"
  rm -f "$build_dir"/*.ext "$build_dir"/*.sim "$build_dir"/*.nodes \
    "$build_dir"/*.spice "$build_dir"/*.log "$report"

  PEX_CELL_ORDER=()
  collect_pex_cells "$cell"
  echo "==> Hierarchical PEX order: ${PEX_CELL_ORDER[*]}"

  for stage in "${PEX_CELL_ORDER[@]}"; do
    stage_tcl="$build_dir/pex_${stage}.tcl"
    stage_log="$build_dir/${stage}_extresist.magic.log"
    cat >"$stage_tcl" <<EOF
crashbackups stop
drc off
load "$root/magic/$stage.mag"
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
extresist blackbox on
extresist all
quit -noprompt
EOF

    echo "==> Extracting hierarchical R+C stage: $stage"
    magic -dnull -noconsole -rcfile "$rcfile" "$stage_tcl" 2>&1 | tee "$stage_log"
    total="$(sed -n 's/.*Total Nets: *//p' "$stage_log" | tail -1)"
    extracted="$(sed -n 's/.*Nets extracted: *\([0-9][0-9]*\).*/\1/p' "$stage_log" | tail -1)"
    output="$(sed -n 's/.*Nets output: *\([0-9][0-9]*\).*/\1/p' "$stage_log" | tail -1)"
    total="${total:-unknown}"
    extracted="${extracted:-unknown}"
    output="${output:-unknown}"
    bad_devices="$(grep -c 'Bad Device Location' "$stage_log" || true)"
    node_errors="$(grep -c 'Error in extracting node' "$stage_log" || true)"
    missing_connections="$(grep -Ec 'Missing (terminal|substrate) connection' "$stage_log" || true)"
    stage_details+="$stage: total=$total extracted=$extracted output=$output bad_device_locations=$bad_devices node_errors=$node_errors missing_connections=$missing_connections log=$stage_log"$'\n'

    if [[ "$total" == "unknown" || "$extracted" == "unknown" || "$output" == "unknown" ]] ||
       [[ "$extracted" != "$total" ]] ||
       grep -Eq 'Bad Device Location|Cannot open file|Error in extracting node|Couldn.t find device|Missing (terminal|substrate) connection' "$stage_log"; then
      failed=1
    fi
    [[ -f "$build_dir/$stage.res.ext" ]] || failed=1
  done

  cat >"$report" <<EOF
cell: $cell
mode: hierarchical extresist with immediate subcells black-boxed
stages: ${PEX_CELL_ORDER[*]}

$stage_details
EOF

  if (( failed != 0 )); then
    echo "==> PEX failed: one or more hierarchy stages were incomplete; see: $report" >&2
    return 1
  fi

  cat >"$assemble_tcl" <<EOF
crashbackups stop
drc off
load "$root/magic/$cell.mag"
select top cell
cd "$build_dir"
ext2spice default
ext2spice hierarchy on
ext2spice subcircuit top on
ext2spice scale off
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice extresist on
ext2spice
quit -noprompt
EOF
  magic -dnull -noconsole -rcfile "$rcfile" "$assemble_tcl" 2>&1 | tee "$assemble_log"
  [[ -f "$raw_spice" ]] || die "Magic did not create expected PEX netlist: $raw_spice"
  mv "$raw_spice" "$pex_spice"
  resistor_count="$(awk '/^[Rr][^[:space:]]*[[:space:]]/ {count++} END {print count+0}' "$pex_spice")"
  capacitor_count="$(awk '/^[Cc][^[:space:]]*[[:space:]]/ {count++} END {print count+0}' "$pex_spice")"
  {
    echo "netlist: $pex_spice"
    echo "PARASITIC_RESISTORS=$resistor_count"
    echo "PARASITIC_CAPACITORS=$capacitor_count"
  } >>"$report"
  if (( resistor_count == 0 || capacitor_count == 0 )); then
    echo "==> PEX failed validation: expected both R and C elements; see: $report" >&2
    return 1
  fi
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
  if grep -q '^Final result: Circuits match uniquely\.$' "$lvs_report"; then
    echo "==> LVS passed"
  else
    echo "==> LVS did not pass; see report: $lvs_report" >&2
    exit 1
  fi
  echo "==> LVS report: $lvs_report"
}

main() {
  local cmd="${1:-}" status=0
  case "$cmd" in
    drc)
      shift
      [[ $# -le 1 ]] || die "too many arguments for drc"
      run_drc "${1:-bgr}"
      ;;
    drc-klayout)
      shift
      [[ $# -le 1 ]] || die "too many arguments for drc-klayout"
      run_klayout_drc "${1:-bgr}"
      ;;
    drc-all)
      shift
      [[ $# -le 1 ]] || die "too many arguments for drc-all"
      run_drc "${1:-bgr}" || status=1
      run_klayout_drc "${1:-bgr}" || status=1
      (( status == 0 )) || return 1
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
      status=0
      run_drc "${1:-bgr}" || status=1
      run_klayout_drc "${1:-bgr}" || status=1
      run_antenna "${1:-bgr}" || status=1
      run_lvs "${1:-bgr}" || status=1
      run_pex "${1:-bgr}" || status=1
      if (( status != 0 )); then
        echo "==> One or more checks failed; see the individual reports above" >&2
        return 1
      fi
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

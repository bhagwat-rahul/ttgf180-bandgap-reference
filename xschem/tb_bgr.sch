v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {BGR Testbench
We want a stable voltage over a temperature range of -40C <-> +125C for VAPWR = 3.3V
Vhigh - Vlow should be least, so do a sweep where voltage change slope is flattest} -390 -390 0 0 0.4 0.4 {
}
N 50 20 140 20 {lab=GND}
N 50 -0 80 0 {lab=#net1}
N 140 -0 140 20 {lab=GND}
N 50 -20 80 -20 {lab=VBGR}
N 80 -90 80 -20 {lab=VBGR}
N 140 -90 140 -0 {lab=GND}
C {vsource.sym} 110 0 3 0 {name=VAPWR value="DC 3.3" savecurrent=false}
C {gnd.sym} 140 20 3 1 {name=l1 lab=GND}
C {bgr.sym} 0 0 0 0 {name=x1}
C {lab_wire.sym} 80 -20 3 1 {name=VBGR sig_type=std_logic lab=VBGR}
C {code.sym} -60 -190 0 0 {name=sim_temp_sweep only_toplevel=false
value=
"
.control
  dc TEMP -40 140 5
  plot v(VBGR)
.endc
"}
C {res.sym} 110 -90 3 0 {name=RLoad
value=10Meg
footprint=1206
device=resistor
m=1}

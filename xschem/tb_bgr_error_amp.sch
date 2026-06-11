v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -240 -60 -240 100 {lab=GND}
N -240 100 220 100 {lab=GND}
N 220 -100 220 100 {lab=GND}
N -240 -100 220 -100 {lab=GND}
N -240 -100 -240 -60 {lab=GND}
N -180 -60 -120 -60 {lab=#net1}
N -120 -60 -120 -20 {lab=#net1}
N -180 60 -120 60 {lab=#net2}
N -120 20 -120 60 {lab=#net2}
N -180 -0 -120 -0 {lab=#net3}
N 110 -60 110 -20 {lab=#net4}
N 110 -60 160 -60 {lab=#net4}
N 110 20 110 60 {lab=GND}
N 110 60 220 60 {lab=GND}
N 110 -0 180 0 {lab=VOUT}
C {bgr_error_amp.sym} 0 0 0 0 {name=xbgr_error_amp}
C {vsource.sym} -210 -60 1 0 {name=BIAS_P value=3 savecurrent=false}
C {vsource.sym} -210 0 1 0 {name=VIN_P value=3 savecurrent=false}
C {vsource.sym} -210 60 1 0 {name=VIN_N value=3 savecurrent=false}
C {gnd.sym} 220 60 3 1 {name=l1 lab=GND}
C {vsource.sym} 190 -60 3 0 {name=VAPWR value="DC 3.3" savecurrent=false}
C {lab_wire.sym} 180 0 0 1 {name=VOUT sig_type=std_logic lab=VOUT}
C {code.sym} -60 -240 0 0 {name=sim_bgr_error_amp_gain_noise only_toplevel=false
value=
"
.op
"}

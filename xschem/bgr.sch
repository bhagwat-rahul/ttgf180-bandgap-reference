v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -360 340 -360 {lab=VAPWR}
N -320 260 340 260 {lab=VGND}
C {iopin.sym} -320 -360 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -320 260 0 1 {name=VGND lab=VGND}
C {opin.sym} 340 0 0 0 {name=VBGR lab=VBGR}
C {symbols/npn_05p00x05p00.sym} -230 -130 0 0 {name=Q1
model=npn_05p00x05p00
spiceprefix=X
m=1}
C {symbols/npn_05p00x05p00.sym} -60 -130 0 0 {name=Q2
model=npn_05p00x05p00
spiceprefix=X
m=8}

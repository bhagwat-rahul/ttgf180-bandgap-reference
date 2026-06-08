v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -30 -0 -0 -0 {lab=VAPWR}
N -0 60 100 60 {lab=VGND}
N 100 40 100 60 {lab=VGND}
N 100 -40 100 -20 {lab=VBGR}
C {iopin.sym} -30 0 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} 100 60 0 0 {name=VGND lab=VGND}
C {opin.sym} 100 -40 0 0 {name=VBGR lab=VBGR}
C {res.sym} 0 30 0 0 {name=Rdummy
value=1G
footprint=1206
device=resistor
m=1}
C {vsource.sym} 100 10 0 0 {name=Vdummy value="DC 1.2" savecurrent=false}
C {symbols/npn_05p00x05p00.sym} -230 -130 0 0 {name=Q1
model=npn_05p00x05p00
spiceprefix=X
m=1}
C {symbols/npn_05p00x05p00.sym} -60 -130 0 0 {name=Q2
model=npn_05p00x05p00
spiceprefix=X
m=8}

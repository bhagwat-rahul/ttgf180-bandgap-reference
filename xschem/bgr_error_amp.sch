v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {5T OTA to act as a CMOS error amp for forcing BJT collector-sense nodes equal in BGR} -460 -420 0 0 0.4 0.4 {}
N -90 120 -60 120 {lab=VGND}
N 80 120 110 120 {lab=VGND}
N -60 120 80 120 {lab=VGND}
N -90 80 110 80 {lab=#net1}
N -120 -10 140 -10 {lab=VAPWR}
N -120 -40 140 -40 {lab=TAIL_P}
N 10 -120 10 -40 {lab=TAIL_P}
N -50 -120 -20 -120 {lab=VAPWR}
N -120 20 -120 120 {lab=#net1}
N -120 80 -90 80 {lab=#net1}
N 140 20 140 120 {lab=VOUT}
C {symbols/pfet_03v3.sym} -140 -10 0 0 {name=MDIFF_P
L=1u
W=5u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X}
C {symbols/pfet_03v3.sym} 160 -10 0 1 {name=MDIFF_N
L=1u
W=5u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X}
C {symbols/pfet_03v3.sym} -20 -140 3 1 {name=MTAIL
L=1u
W=4u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -90 100 3 1 {name=MLOAD_REF
L=1u
W=2u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X}
C {symbols/nfet_03v3.sym} 110 100 1 0 {name=MLOAD_OUT
L=1u
W=2u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_wire.sym} 10 -10 3 0 {name=VAPWR sig_type=std_logic lab=VAPWR}
C {lab_wire.sym} 10 -80 0 1 {name=TAIL_P sig_type=std_logic lab=TAIL_P}
C {ipin.sym} -160 -10 0 0 {name=VIN_P1 lab=VIN_P}
C {ipin.sym} 180 -10 2 0 {name=VIN_N1 lab=VIN_N}
C {ipin.sym} -20 -160 1 0 {name=BIAS_P lab=BIAS_P}
C {iopin.sym} -50 -120 0 1 {name=VAPWR1 lab=VAPWR}
C {iopin.sym} 10 120 1 0 {name=VGND1 lab=VGND}
C {opin.sym} 140 70 0 0 {name=VOUT1 lab=VOUT}

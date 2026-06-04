v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 30 -160 160 {lab=#net1}
N 180 30 180 160 {lab=VOUT}
N -130 160 150 160 {lab=VGND}
N -160 120 -130 120 {lab=#net1}
N -160 0 180 0 {lab=VDPWR}
N -160 -30 180 -30 {lab=#net2}
N -0 -160 0 -30 {lab=#net2}
N -0 -220 -0 -190 {lab=VDPWR}
N -130 120 150 120 {lab=#net1}
N 180 80 240 80 {lab=VOUT}
N -260 -0 -200 0 {lab=VIN_P}
N 220 -0 280 0 {lab=VIN_N}
N -110 -190 -40 -190 {lab=BIAS_P}
N -0 -220 120 -220 {lab=VDPWR}
N 120 -220 120 -0 {lab=VDPWR}
N -0 160 0 200 {lab=VGND}
C {symbols/pfet_03v3.sym} 200 0 0 1 {name=M1
L=0.28u
W=0.22u
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
C {symbols/pfet_03v3.sym} -180 0 0 0 {name=M2
L=0.28u
W=0.22u
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
C {symbols/pfet_03v3.sym} -20 -190 0 0 {name=M3
L=0.28u
W=0.22u
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
C {symbols/nfet_03v3.sym} 150 140 1 0 {name=M4
L=0.28u
W=0.22u
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
C {symbols/nfet_03v3.sym} -130 140 3 1 {name=M5
L=0.28u
W=0.22u
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
C {opin.sym} 240 80 0 0 {name=VOUT lab=VOUT}
C {ipin.sym} -260 0 0 0 {name=VIN_P lab=VIN_P}
C {ipin.sym} 280 0 0 1 {name=VIN_N lab=VIN_N}
C {ipin.sym} -110 -190 0 0 {name=BIAS_P lab=BIAS_P}
C {iopin.sym} 120 -220 0 0 {name=VDPWR lab=VDPWR}
C {iopin.sym} 0 200 1 0 {name=VNGD lab=VGND}

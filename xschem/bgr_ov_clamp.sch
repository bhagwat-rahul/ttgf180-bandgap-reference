v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 -190 -120 -160 {lab=VAPWR}
N -120 -130 -120 -90 {lab=OV_N}
N -120 -90 -120 -60 {lab=OV_N}
N -120 -30 -120 0 {lab=VGND}
N -160 -160 -150 -160 {lab=VBGR}
N -160 -160 -160 -30 {lab=VBGR}
N 260 -190 260 -160 {lab=VAPWR}
N 260 -130 260 -90 {lab=VCTRL}
N 260 -90 320 -90 {lab=VCTRL}
N -120 -190 260 -190 {lab=VAPWR}
N -120 -100 220 -100 {lab=OV_N}
N 220 -160 220 -100 {lab=OV_N}
C {symbols/nfet_03v3.sym} -140 -30 0 0 {name=MOVDET_N
L=1u
W=0.3u
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
C {symbols/pfet_03v3.sym} -140 -160 0 0 {name=MOVDET_P
L=4u
W=8u
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
C {symbols/pfet_03v3.sym} 240 -160 0 0 {name=MOVCLAMP
L=8u
W=0.5u
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
C {iopin.sym} 70 -190 1 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -120 0 3 1 {name=VGND lab=VGND}
C {ipin.sym} -160 -100 0 0 {name=VBGR lab=VBGR}
C {iopin.sym} 320 -90 0 0 {name=VCTRL lab=VCTRL}
C {lab_wire.sym} 60 -100 0 1 {name=OV_N sig_type=std_logic lab=OV_N}

v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -290 90 -290 {lab=START_ON}
N -60 -320 50 -320 {lab=VBGR}
N -100 -350 -100 -320 {lab=VAPWR}
N 90 -350 90 -320 {lab=VGND}
N -100 -420 -100 -350 {lab=VAPWR}
N 110 -140 110 -110 {lab=VGND}
N -100 -140 -100 -110 {lab=VGND}
N -60 -140 70 -140 {lab=START_ON}
N -100 -200 -100 -170 {lab=VCTRL}
N 110 -200 110 -170 {lab=BIAS_P}
N -100 -110 110 -110 {lab=VGND}
N -0 -290 0 -140 {lab=START_ON}
N -0 -350 -0 -320 {lab=VBGR}
N -260 -420 240 -420 {lab=VAPWR}
N -260 -60 260 -60 {lab=VGND}
N -0 -110 -0 -60 {lab=VGND}
N 90 -350 220 -350 {lab=VGND}
N 220 -350 220 -60 {lab=VGND}
C {iopin.sym} -260 -420 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -260 -60 0 1 {name=VGND lab=VGND}
C {ipin.sym} 0 -350 1 0 {name=VBGR1 lab=VBGR}
C {iopin.sym} 110 -200 3 0 {name=BIAS_P lab=BIAS_P}
C {iopin.sym} -100 -200 3 0 {name=VCTRL lab=VCTRL}
C {lab_wire.sym} 0 -200 1 0 {name=START_ON sig_type=std_logic lab=START_ON}
C {symbols/nfet_03v3.sym} 70 -320 2 1 {name=MDET_N
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
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 90 -140 0 0 {name=MST_BIAS
L=4u
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
C {symbols/nfet_03v3.sym} -80 -140 0 1 {name=MST_CTRL
L=4u
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
C {symbols/pfet_03v3.sym} -80 -320 0 1 {name=MDET_P
L=4u
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

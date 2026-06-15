v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -190 -630 -160 -630 {lab=VAPWR}
N -130 -560 -130 -460 {lab=VCTRL}
N 150 -560 150 -460 {lab=VCTRL}
N -160 -600 -160 -420 {lab=VAPWR}
N -160 -420 -130 -420 {lab=VAPWR}
N -160 -600 -130 -600 {lab=VAPWR}
N 150 -600 180 -600 {lab=VAPWR}
N 180 -600 180 -420 {lab=VAPWR}
N 150 -420 180 -420 {lab=VAPWR}
N -140 -260 120 -260 {lab=VBGR}
N -100 -420 -100 -290 {lab=VN1}
N 120 -420 120 -290 {lab=VN2}
N -130 -510 150 -510 {lab=VCTRL}
N 120 -230 120 -200 {lab=E2}
N -100 -230 -100 -140 {lab=E1}
N -100 -140 120 -140 {lab=E1}
N 120 -260 380 -260 {lab=VBGR}
N 120 -700 120 -600 {lab=VBGR}
N 120 -700 380 -700 {lab=VBGR}
N 380 -700 380 -260 {lab=VBGR}
N 380 -260 380 -180 {lab=VBGR}
N 380 -120 380 -0 {lab=VGND}
N -100 -0 380 -0 {lab=VGND}
N -100 -140 -100 -100 {lab=E1}
N -100 -40 -100 -0 {lab=VGND}
N -210 -780 -100 -780 {lab=VGND}
N -100 -740 -70 -740 {lab=NBIAS_N}
N -70 -780 -70 -740 {lab=NBIAS_N}
N -210 -740 -100 -740 {lab=NBIAS_N}
N -100 -740 -100 -600 {lab=NBIAS_N}
N -240 -780 -240 -670 {lab=BIAS_P}
N -160 -540 180 -540 {lab=VAPWR}
N -150 -900 -150 -780 {lab=VGND}
N -340 -900 -150 -900 {lab=VGND}
N -340 -900 -340 0 {lab=VGND}
N -340 0 -100 -0 {lab=VGND}
N -160 -630 -160 -600 {lab=VAPWR}
N -220 -670 -220 -630 {lab=BIAS_P}
N -220 -670 -190 -670 {lab=BIAS_P}
N -240 -670 -220 -670 {lab=BIAS_P}
N 140 -170 140 -0 {lab=VGND}
N 380 -120 400 -120 {lab=VGND}
N 400 -150 400 -120 {lab=VGND}
N -120 -70 -120 -40 {lab=VGND}
N -120 -40 -100 -40 {lab=VGND}
C {symbols/npn_05p00x05p00.sym} -120 -260 0 0 {name=Q1
model=npn_05p00x05p00
spiceprefix=X
m=1}
C {symbols/npn_05p00x05p00.sym} 100 -260 0 0 {name=Q2
model=npn_05p00x05p00
spiceprefix=X
m=8}
C {symbols/ppolyf_u_3k.sym} 120 -170 0 1 {name=R1
W=1.18e-6
L=1e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_3k.sym} -100 -70 0 0 {name=R2
W=1e-6
L=25e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_3k.sym} 380 -150 0 1 {name=R3
W=1e-6
L=50e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {symbols/pfet_03v3.sym} 150 -440 1 0 {name=M1
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
C {symbols/pfet_03v3.sym} -130 -440 3 1 {name=M2
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
C {iopin.sym} 140 0 1 0 {name=VGND lab=VGND}
C {symbols/pfet_03v3.sym} -130 -580 3 0 {name=M3
L=4u
W=2u
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
C {symbols/pfet_03v3.sym} 150 -580 1 1 {name=M4
L=4u
W=64u
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
C {symbols/pfet_03v3.sym} -190 -650 1 0 {name=M5
L=4u
W=1u
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
C {symbols/nfet_03v3.sym} -210 -760 3 0 {name=M6
L=4u
W=1u
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
C {symbols/nfet_03v3.sym} -100 -760 1 1 {name=M7
L=4u
W=1u
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
C {iopin.sym} 0 -540 3 0 {name=VAPWR lab=VAPWR}
C {opin.sym} 380 -260 0 0 {name=VBGR lab=VBGR}
C {ipin.sym} 0 -510 3 0 {name=VCTRL lab=VCTRL}
C {opin.sym} -240 -670 0 1 {name=BIAS_P lab=BIAS_P}
C {opin.sym} -100 -420 0 0 {name=VN1 lab=VN1}
C {opin.sym} 120 -420 0 1 {name=VN2 lab=VN2}
C {lab_wire.sym} 120 -210 0 0 {name=E2 sig_type=std_logic lab=E2}
C {lab_wire.sym} -100 -210 0 1 {name=E1 sig_type=std_logic lab=E1}
C {lab_wire.sym} -100 -690 0 0 {name=NBIAS_N sig_type=std_logic lab=NBIAS_N}

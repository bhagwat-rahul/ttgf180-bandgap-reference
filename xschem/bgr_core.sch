v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -360 340 -360 {lab=VAPWR}
N -320 260 340 260 {lab=VGND}
N 20 -230 20 -180 {lab=#net1}
N -300 -60 -300 260 {lab=VGND}
N -240 -230 -240 -120 {lab=#net2}
N -300 -60 -240 -60 {lab=VGND}
N -240 -260 -200 -260 {lab=VBGR}
N -380 -260 -240 -260 {lab=VBGR}
N -380 -320 -380 -260 {lab=VBGR}
N -380 -320 140 -320 {lab=VBGR}
N 140 -320 140 -260 {lab=VBGR}
N 20 -260 140 -260 {lab=VBGR}
N -20 -260 20 -260 {lab=VBGR}
N -240 -300 -240 -290 {lab=#net3}
N -240 -300 -180 -300 {lab=#net3}
N 20 -300 20 -290 {lab=#net4}
N -40 -290 -40 -20 {lab=#net4}
N -40 -300 -40 -290 {lab=#net4}
N -40 -300 20 -300 {lab=#net4}
N -240 -120 20 -120 {lab=#net2}
N -180 -300 -180 -20 {lab=#net3}
N -180 10 -180 40 {lab=VAPWR}
N -40 10 -40 40 {lab=VAPWR}
N -180 40 -40 40 {lab=VAPWR}
N -110 -360 -110 40 {lab=VAPWR}
N -220 10 -220 80 {lab=VCTRL}
N -220 80 -0 80 {lab=VCTRL}
N 0 10 -0 80 {lab=VCTRL}
N 420 0 420 90 {lab=VBGR}
N 420 150 420 260 {lab=VGND}
N -50 190 -50 220 {lab=#net5}
N -90 190 -50 190 {lab=#net5}
N 160 160 160 190 {lab=#net6}
N 160 190 200 190 {lab=#net6}
N 200 130 200 160 {lab=VAPWR}
N 110 220 110 250 {lab=VGND}
N -90 250 110 250 {lab=VGND}
N -50 220 70 220 {lab=#net5}
N -0 250 -0 260 {lab=VGND}
N 0 -30 0 10 {lab=VCTRL}
N 40 -0 340 0 {lab=VBGR}
N 40 -60 40 -30 {lab=VAPWR}
N 40 -120 40 -60 {lab=VAPWR}
N 40 -120 160 -120 {lab=VAPWR}
N 160 -360 160 -120 {lab=VAPWR}
N 340 260 420 260 {lab=VGND}
N 340 -0 420 0 {lab=VBGR}
N 300 80 300 260 {lab=VGND}
N 300 -360 300 40 {lab=VAPWR}
N 20 190 110 190 {lab=#net6}
N 20 40 20 190 {lab=#net6}
N 20 40 70 40 {lab=#net6}
N 0 10 320 10 {lab=VCTRL}
N 320 10 320 60 {lab=VCTRL}
N 300 60 320 60 {lab=VCTRL}
N -260 -20 -180 -20 {lab=#net3}
N -260 -20 -260 120 {lab=#net3}
N -260 120 40 120 {lab=#net3}
N 40 60 40 120 {lab=#net3}
N 40 60 70 60 {lab=#net3}
N -40 -20 10 -20 {lab=#net4}
N 10 -20 10 80 {lab=#net4}
N 10 80 70 80 {lab=#net4}
N 110 190 160 190 {lab=#net6}
N 200 -360 200 130 {lab=VAPWR}
N -90 220 -90 250 {lab=VGND}
N 140 -320 420 -320 {lab=VBGR}
N 420 -320 420 -0 {lab=VBGR}
N -220 80 -220 140 {lab=VCTRL}
N -190 180 -90 180 {lab=#net5}
N -90 180 -90 190 {lab=#net5}
N -250 180 -220 180 {lab=VAPWR}
N -280 180 -250 180 {lab=VAPWR}
N -280 -360 -280 180 {lab=VAPWR}
C {iopin.sym} -320 -360 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -320 260 0 1 {name=VGND lab=VGND}
C {opin.sym} 420 0 0 0 {name=VBGR lab=VBGR}
C {symbols/npn_05p00x05p00.sym} -220 -260 0 1 {name=Q1
model=npn_05p00x05p00
spiceprefix=X
m=1}
C {symbols/npn_05p00x05p00.sym} 0 -260 0 0 {name=Q2
model=npn_05p00x05p00
spiceprefix=X
m=8}
C {symbols/pfet_03v3.sym} -200 10 2 1 {name=M1
L=2u
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
C {symbols/pfet_03v3.sym} -20 10 2 0 {name=M2
L=2u
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
C {symbols/pfet_03v3.sym} 20 -30 0 0 {name=M3
L=2u
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
C {symbols/ppolyf_u_3k.sym} -240 -90 0 1 {name=R1
W=1e-6
L=1e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_3k.sym} 20 -150 0 0 {name=R2
W=1e-6
L=1e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {bgr_error_amp.sym} 190 60 0 0 {name=x1}
C {lab_wire.sym} -110 80 1 1 {name=VCTRL lab=VCTRL}
C {symbols/ppolyf_u_3k.sym} 420 120 0 1 {name=R3
W=1e-6
L=1e-6
model=ppolyf_u_3k
spiceprefix=X
m=1}
C {symbols/nfet_03v3.sym} -70 220 0 1 {name=MNBIAS_REF
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
C {symbols/nfet_03v3.sym} 90 220 0 0 {name=MNBIAS_SINK
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
C {symbols/pfet_03v3.sym} 180 160 0 0 {name=MPBIAS_DIODE
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
C {symbols/pfet_03v3.sym} -220 160 3 1 {name=M4
L=2u
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

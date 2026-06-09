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
N -240 -260 -200 -260 {lab=#net3}
N -380 -260 -240 -260 {lab=#net3}
N -380 -320 -380 -260 {lab=#net3}
N -380 -320 140 -320 {lab=#net3}
N 140 -320 140 -260 {lab=#net3}
N 20 -260 140 -260 {lab=#net3}
N -20 -260 20 -260 {lab=#net3}
N -240 -300 -240 -290 {lab=#net4}
N -240 -300 -180 -300 {lab=#net4}
N 20 -300 20 -290 {lab=#net5}
N -40 -290 -40 -20 {lab=#net5}
N -40 -300 -40 -290 {lab=#net5}
N -40 -300 20 -300 {lab=#net5}
N -240 -120 20 -120 {lab=#net2}
N -180 -300 -180 -20 {lab=#net4}
N -180 10 -180 40 {lab=VAPWR}
N -40 10 -40 40 {lab=VAPWR}
N -180 40 -40 40 {lab=VAPWR}
N -110 -360 -110 40 {lab=VAPWR}
N -220 10 -220 80 {lab=#net6}
N -220 80 -0 80 {lab=#net6}
N 0 10 -0 80 {lab=#net6}
C {iopin.sym} -320 -360 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -320 260 0 1 {name=VGND lab=VGND}
C {opin.sym} 340 0 0 0 {name=VBGR lab=VBGR}
C {symbols/npn_05p00x05p00.sym} -220 -260 0 1 {name=Q1
model=npn_05p00x05p00
spiceprefix=X
m=1}
C {symbols/npn_05p00x05p00.sym} 0 -260 0 0 {name=Q2
model=npn_05p00x05p00
spiceprefix=X
m=8}
C {symbols/pfet_03v3.sym} -200 10 2 1 {name=M1
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
C {symbols/pfet_03v3.sym} -20 10 2 0 {name=M2
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
C {symbols/pfet_03v3.sym} -110 160 0 0 {name=M3
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

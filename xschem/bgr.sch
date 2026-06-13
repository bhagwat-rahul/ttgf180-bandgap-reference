v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 -10 40 -10 {lab=#net1}
N -80 10 40 10 {lab=#net2}
N 270 -10 330 -10 {lab=#net3}
N 330 -120 330 -10 {lab=#net3}
N -380 -120 330 -120 {lab=#net3}
N -380 -120 -380 -50 {lab=#net3}
N -80 -50 40 -50 {lab=#net4}
N 40 -50 40 -30 {lab=#net4}
N -80 30 -0 30 {lab=VBGR}
N -0 30 0 100 {lab=VBGR}
N 270 -30 300 -30 {lab=VAPWR}
N 300 -30 300 100 {lab=VAPWR}
N 300 120 380 120 {lab=#net4}
N 380 -80 380 120 {lab=#net4}
N -40 -80 380 -80 {lab=#net4}
N -40 -80 -40 -50 {lab=#net4}
N -80 50 -80 200 {lab=VGND}
N -80 200 300 200 {lab=VGND}
N 300 160 300 200 {lab=VGND}
N 270 10 340 10 {lab=VGND}
N 340 10 340 200 {lab=VGND}
N 300 200 340 200 {lab=VGND}
N -80 -30 20 -30 {lab=VAPWR}
N 20 -30 20 60 {lab=VAPWR}
N 20 60 300 60 {lab=VAPWR}
N 300 140 380 140 {lab=#net3}
N 380 140 380 220 {lab=#net3}
N -380 220 380 220 {lab=#net3}
N -380 -50 -380 220 {lab=#net3}
C {bgr_core_without_amp.sym} -230 0 0 0 {name=x1}
C {bgr_error_amp.sym} 160 -10 0 0 {name=x2}
C {bgr_startup.sym} 150 130 0 0 {name=x3}
C {iopin.sym} 300 40 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -80 150 0 0 {name=VGND lab=VGND}
C {opin.sym} -30 30 1 0 {name=VBGR lab=VBGR}

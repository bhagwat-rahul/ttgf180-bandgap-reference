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
N -80 30 -0 30 {lab=ua[0]}
N 270 -30 300 -30 {lab=VAPWR}
N -80 50 -80 200 {lab=VGND}
N -80 200 300 200 {lab=VGND}
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
N 0 30 -0 120 {lab=ua[0]}
N 300 160 340 160 {lab=VGND}
N 300 -30 300 120 {lab=VAPWR}
C {bgr_core_without_amp.sym} -230 0 0 0 {name=xbgr_core}
C {bgr_error_amp.sym} 160 -10 0 0 {name=xbgr_amp}
C {bgr_ov_clamp.sym} 150 140 0 0 {name=xbgr_ov_clamp}
C {iopin.sym} 300 40 0 1 {name=VAPWR lab=VAPWR}
C {iopin.sym} -80 150 0 0 {name=VGND lab=VGND}
C {opin.sym} -30 30 1 0 {name=ua0 lab=ua[0]}
C {iopin.sym} 500 -300 0 0 {name=p0 lab=clk}
C {iopin.sym} 600 -300 0 0 {name=p1 lab=ena}
C {iopin.sym} 700 -300 0 0 {name=p2 lab=rst_n}
C {iopin.sym} 800 -300 0 0 {name=p3 lab=ua[1]}
C {iopin.sym} 900 -300 0 0 {name=p4 lab=ua[2]}
C {iopin.sym} 1000 -300 0 0 {name=p5 lab=ua[3]}
C {iopin.sym} 500 -360 0 0 {name=p6 lab=ua[4]}
C {iopin.sym} 600 -360 0 0 {name=p7 lab=ua[5]}
C {iopin.sym} 700 -360 0 0 {name=p8 lab=ua[6]}
C {iopin.sym} 800 -360 0 0 {name=p9 lab=ua[7]}
C {iopin.sym} 900 -360 0 0 {name=p10 lab=ui_in[0]}
C {iopin.sym} 1000 -360 0 0 {name=p11 lab=ui_in[1]}
C {iopin.sym} 500 -420 0 0 {name=p12 lab=ui_in[2]}
C {iopin.sym} 600 -420 0 0 {name=p13 lab=ui_in[3]}
C {iopin.sym} 700 -420 0 0 {name=p14 lab=ui_in[4]}
C {iopin.sym} 800 -420 0 0 {name=p15 lab=ui_in[5]}
C {iopin.sym} 900 -420 0 0 {name=p16 lab=ui_in[6]}
C {iopin.sym} 1000 -420 0 0 {name=p17 lab=ui_in[7]}
C {iopin.sym} 500 -480 0 0 {name=p18 lab=uio_in[0]}
C {iopin.sym} 600 -480 0 0 {name=p19 lab=uio_in[1]}
C {iopin.sym} 700 -480 0 0 {name=p20 lab=uio_in[2]}
C {iopin.sym} 800 -480 0 0 {name=p21 lab=uio_in[3]}
C {iopin.sym} 900 -480 0 0 {name=p22 lab=uio_in[4]}
C {iopin.sym} 1000 -480 0 0 {name=p23 lab=uio_in[5]}
C {iopin.sym} 500 -540 0 0 {name=p24 lab=uio_in[6]}
C {iopin.sym} 600 -540 0 0 {name=p25 lab=uio_in[7]}
C {iopin.sym} 700 -540 0 0 {name=p26 lab=uio_oe[0]}
C {iopin.sym} 800 -540 0 0 {name=p27 lab=uio_oe[1]}
C {iopin.sym} 900 -540 0 0 {name=p28 lab=uio_oe[2]}
C {iopin.sym} 1000 -540 0 0 {name=p29 lab=uio_oe[3]}
C {iopin.sym} 500 -600 0 0 {name=p30 lab=uio_oe[4]}
C {iopin.sym} 600 -600 0 0 {name=p31 lab=uio_oe[5]}
C {iopin.sym} 700 -600 0 0 {name=p32 lab=uio_oe[6]}
C {iopin.sym} 800 -600 0 0 {name=p33 lab=uio_oe[7]}
C {iopin.sym} 900 -600 0 0 {name=p34 lab=uio_out[0]}
C {iopin.sym} 1000 -600 0 0 {name=p35 lab=uio_out[1]}
C {iopin.sym} 500 -660 0 0 {name=p36 lab=uio_out[2]}
C {iopin.sym} 600 -660 0 0 {name=p37 lab=uio_out[3]}
C {iopin.sym} 700 -660 0 0 {name=p38 lab=uio_out[4]}
C {iopin.sym} 800 -660 0 0 {name=p39 lab=uio_out[5]}
C {iopin.sym} 900 -660 0 0 {name=p40 lab=uio_out[6]}
C {iopin.sym} 1000 -660 0 0 {name=p41 lab=uio_out[7]}
C {iopin.sym} 500 -720 0 0 {name=p42 lab=uo_out[0]}
C {iopin.sym} 600 -720 0 0 {name=p43 lab=uo_out[1]}
C {iopin.sym} 700 -720 0 0 {name=p44 lab=uo_out[2]}
C {iopin.sym} 800 -720 0 0 {name=p45 lab=uo_out[3]}
C {iopin.sym} 900 -720 0 0 {name=p46 lab=uo_out[4]}
C {iopin.sym} 1000 -720 0 0 {name=p47 lab=uo_out[5]}
C {iopin.sym} 500 -780 0 0 {name=p48 lab=uo_out[6]}
C {iopin.sym} 600 -780 0 0 {name=p49 lab=uo_out[7]}
C {iopin.sym} 700 -780 0 0 {name=p50 lab=VDPWR}

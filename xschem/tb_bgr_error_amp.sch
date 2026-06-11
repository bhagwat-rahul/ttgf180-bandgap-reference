v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -240 -60 -240 100 {lab=GND}
N -240 100 220 100 {lab=GND}
N 220 -100 220 100 {lab=GND}
N -240 -100 220 -100 {lab=GND}
N -240 -100 -240 -60 {lab=GND}
N -180 -60 -120 -60 {lab=bias_p}
N -120 -60 -120 -20 {lab=bias_p}
N -180 60 -120 60 {lab=vin_n}
N -120 20 -120 60 {lab=vin_n}
N -180 -0 -120 -0 {lab=vin_p}
N 110 -60 110 -20 {lab=#net1}
N 110 -60 160 -60 {lab=#net1}
N 110 20 110 60 {lab=GND}
N 110 60 220 60 {lab=GND}
N 110 -0 180 0 {lab=VOUT}
C {vsource.sym} -210 -60 1 0 {name=VBIAS_P value="DC 2.3" savecurrent=false}
C {vsource.sym} -210 0 1 0 {name=VIN_P value="DC 1.2 AC 0.5" savecurrent=false}
C {vsource.sym} -210 60 1 0 {name=VIN_N value="DC 1.2 AC -0.5" savecurrent=false}
C {gnd.sym} 220 60 3 1 {name=l1 lab=GND}
C {vsource.sym} 190 -60 3 0 {name=VAPWR value="DC 3.3" savecurrent=false}
C {lab_wire.sym} 180 0 0 1 {name=VOUT sig_type=std_logic lab=VOUT}
C {code.sym} -60 -240 0 0 {name=sim_bgr_error_amp_gain_noise only_toplevel=false
value=
"
.param sw_stat_global=1  ; enable statistical variation (0 = OFF, 1 = ON)
.param mc_skew=1         ; MOS variation scale factor (1 = Nominal)
.param res_mc_skew=1     ; resistor variation scale factor (1 = Nominal)
.param fnoicor=0         ; flicker noise model selector
.param sw_stat_mismatch=0
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice statistical
.control
op
ac dec 100 1 1e9
plot db(v(VOUT))
.endc
"}
C {bgr_error_amp.sym} 0 0 0 0 {name=xbgr_error_amp}
C {lab_wire.sym} -140 0 0 0 {name=vin_p1 sig_type=std_logic lab=vin_p}
C {lab_wire.sym} -120 60 2 1 {name=vin_n1 sig_type=std_logic lab=vin_n}
C {lab_wire.sym} -120 -60 0 0 {name=bias_p sig_type=std_logic lab=bias_p}

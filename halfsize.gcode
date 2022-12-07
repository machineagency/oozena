; PREAMBLE (copied)
M73 P0 R2
M73 Q0 S2
M201 X1000 Y1000 Z1000 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 P1250 R1250 T1250 ; sets acceleration (P, T) and retract acceleration (R), mm/sec^2
M205 X8.00 Y8.00 Z0.40 E1.50 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M107
; M115 U3.6.0 ; tell printer latest fw version
M83  ; extruder relative mode
M302 P1 ; CAREFUL - enable cold extrusion
M104 S185 ; set extruder temp - set high for first layer only
M140 S60 ; set bed temp
M190 S60 ; wait for bed temp
M109 S185 ; wait for extruder temp
G28 W ; home all without mesh bed level
; G80 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside print area
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
M73 Q2 S2
M73 P2 R2
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M900 K30; Filament gcode
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
; END PREAMBLE

; Should be 0.2, but it seems it's getting squished
G1 X60 Y100 Z0.4 E12.5 F2000 ; go to start
G1 X100 Y100 Z0.4 E2.5 F250 ; base

; M104 S185 ; set extruder temp - shift down to main printing temp
; M109 S185 ; wait for extruder temp

M106 S255 ; fan on max

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 Z5 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X90 Y100 Z0.2 E2.0 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z5 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X80 Y100 Z0.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z5 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X70 Y100 Z0.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z5 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X60 Y100 Z0.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z5 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; extrude bead
G4 P1000 ; wait a second

; Top line
; M0 How does it look boss? ; Pause and check if you like
G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X70 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X80 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X90 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X100 E1.5 F3000 ; bridge


;;; SECOND LAYER

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 Z10 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
;G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X90 Y100 Z5.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z10 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
;G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X80 Y100 Z5.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z10 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
;G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X70 Y100 Z5.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z10 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X60 Y100 Z5.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z10 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; extrude bead
G4 P1000 ; wait a second

; Top line

G1 E0.2 ; extrude bead
G1 X70 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X80 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X90 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X100 E1.5 F3000 ; bridge



;; THIRD LAYER

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 Z15 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X90 Y100 Z10.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z15 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
;G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X80 Y100 Z10.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z15 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X70 Y100 Z10.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z15 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; unretract
G4 P1000 ; wait a second
G1 X60 Y100 Z10.2 E1.5 F3000 ; hypotenuse

G1 E0.2 ; extrude for base
G1 Z15 E0.35 F500 ; vertical side
G1 E-0.2 ; retract for tension
G4 P1000 ; wait a second
G1 E0.2 ; extrude bead
G4 P1000 ; wait a second

; Top line

G1 E0.2 ; extrude bead
G1 X70 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X80 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X90 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead
G1 X100 E1.5 F3000 ; bridge

G4 P1500 ; wait a second
G1 E0.2 ; extrude bead


M107 ; fan off
G1 E0.2
G1 X120 F500
G1 Z30 F500

; POSTAMBLE (copied)
; Filament-specific end gcode
G4 ; wait
M221 S100
;M104 S0 ; turn off temperature
;M140 S0 ; turn off heatbed
;M302 P0 ; disable cold extrusion
M107 ; turn off fan
G1 Z31.55 ; Move print head up
G1 X0 Y200; home X axis
M84 ; disable motors



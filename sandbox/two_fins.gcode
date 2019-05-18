
; PREAMBLE (copied)

M73 P0 R2
M73 Q0 S2
M201 X1000 Y1000 Z1000 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 P1250 R1250 T1250 ; sets acceleration (P, T) and retract acceleration (R), mm/sec^2
M205 X8.00 Y8.00 Z0.40 E1.50 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M107
M115 U3.6.0 ; tell printer latest fw version
M83  ; extruder relative mode
M104 S215 ; set extruder temp
M140 S60 ; set bed temp
M190 S60 ; wait for bed temp
M109 S215 ; wait for extruder temp
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling
G1 Y-3.0 F1000.0 ; go outside print area
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
M73 Q2 S2
M73 P2 R2
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

; COMMENCE SQUARE

; IDK what this is
;BEFORE_LAYER_CHANGE
G92 E0.0
;0.2
G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000
;AFTER_LAYER_CHANGE
;0.2
G1 X117.240 Y97.979 ; Starting XY point
G1 Z0.200
G1 E0.80000 F2100.00000
M204 S1000
G1 F1200

; Start square, starting at the XY point
; We are moving 5mm, so extrude 5mm times ratio of post-extruded filament
; (0.4mm) over pre-extruded filament (1.75) 
G1 X137.240 Y97.979 E4.5714
G1 X157.240 Y97.979 E4.5714

G1 F2400
G1 Z5.000 E1.1429
G4 P3000
G1 X137.240 Y97.979 Z0.000 E4.7121

G1 F2400
G1 Z5.000 E1.1429
G4 P3000
G1 X117.240 Y97.979 Z0.000 E4.7121


; POSTAMBLE (copied)
M107
; Filament-specific end gcode
G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
M107 ; turn off fan
G1 Z31.55 ; Move print head up
G1 X0 Y200; home X axis
M84 ; disable motors


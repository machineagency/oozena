# GCode fun

In general, easier to test with relative coordinates.

Fan on at max

`M106 S255`

Fan off

`M107`

Bed temp

`M140 S60`

Extruder temp (minimum effective ~205 C)

`M104 S215`

Extruder Relative Coordinates

`M83`

Max length vertical with rate

`G1 Z20 E4.00 F50`


Single fin v1

```
G1 X100 Y100 Z0 F2000
G1 X130 Y100 Z0 E4 F500 ; base
G1 Z20 E4.00 F50 ; vertical side
G1 X100 Y100 Z0 E4 F50 ; hypotenuse
```

Too big, try smaller fin

```
G1 X100 Y100 Z0 F2000
G1 X120 Y100 Z0 E2 F500 ; base
G1 Z10 E2.00 F50 ; vertical side
G1 X100 Y100 Z0 E0.5 F50 ; hypotenuse
```

This is doing well, but try to make hypotenuse thicker without buckling

```
G1 X100 Y100 Z0.2 F2000
G1 X120 Y100 Z0.2 E2.5 F500 ; base
G1 Z10 E2.00 F50 ; vertical side
G1 E0.2 F500 ; preemptive extrude before hypotenuse
G1 X100 Y100 Z0.2 E2. F50 ; hypotenuse
```

Above worked okay at 205. Need to think about how to get hypotenuse less wiggly.


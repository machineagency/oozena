#lang racket

; Global constants

(define TRI-HEIGHT 5)
(define FEED-SLOW 500)
(define FEED-MEDIUM 2000)
(define FEED-FAST 3000)
(define V-EXT-RATE 0.35)
(define HYP-EXT-RATE 1.5)
(define BRIDGE-EXT-RATE 1.5)
(define LAYER-HEIGHT 0.2)

; GCode Wrappers

(define (fan-on)
  ("M106 S255"))

(define (move-xy x y)
  (string-append "G1 X" (number->string x) " Y" (number->string y)))

(define (extrude-bead)
  ("G1 E0.2"))

(define (retract len)
  ("G1 E-" (number->string len)))

(define (wait msec)
  (string-append "G4 P" (number->string msec)))

; Primitives

(define (vertical from-height)
  (string-append
    "G1 Z"(number->string (+ from-height TRI-HEIGHT))
    " E" (number->string V-EXT-RATE)
    " F" (number->string FEED-SLOW)))

(define (hyp from-z to-x to-y)
  (string-append
    "G1 X" (number->string to-x)
    " Y" (number->string to-y)
    " Z" (number->string (+ (- from-z TRI-HEIGHT) LAYER-HEIGHT))
    " E" (number->string HYP-EXT-RATE)
    " F" (number->string FEED-FAST)))

(define (bridge to-x to-y)
  (string-append
    "G1 X" (number->string to-x)
    " Y" (number->string to-y)
    " E" (number->string BRIDGE-EXT-RATE)
    " F" (number->string FEED-FAST)))

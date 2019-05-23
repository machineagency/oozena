#lang racket

; Global constants

(define TRI-HEIGHT 5)
(define TRI-LENGTH 10)
(define FEED-SLOW 500)
(define FEED-MEDIUM 2000)
(define FEED-FAST 3000)
(define V-EXT-RATE 0.35)
(define HYP-EXT-RATE 1.5)
(define BRIDGE-EXT-RATE 1.5)
(define LAYER-HEIGHT 0.2)
(define WAIT-MSEC 2000)
(define NL "\n")

(define (get-x point) (car point))
(define (get-y point) (cadr point))
(define (get-z point) (caddr point))

; GCode Wrappers

(define (fan-on)
  ("M106 S255"))

(define (move-xy x y)
  (string-append "G1 X" (number->string x) " Y" (number->string y)))

(define (extrude-bead)
  "G1 E0.2")

(define (retract len)
  ("G1 E-" (number->string len)))

(define (wait)
  (string-append "G4 P" (number->string WAIT-MSEC)))

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

(define (transl-point origin vector)
  (let
    ([x (+ (get-x origin) (get-x vector))]
    [y (+ (get-y origin) (get-y vector))]
    [z (+ (get-z origin) (get-z vector))])
    (list x y z)))

(def (mul-vector vector scalar)
  (map (lambda (el) (+ el scalar)) vector))

; to-do normalize vector to be base width
(define (triangle origin vector base-height)
  (string-append
    (extrude-bead) NL
    (vertical base-height) NL
    (wait) NL
    (let
      ([from-z (+ base-height TRI-HEIGHT)]
       [to-x (get-x (transl-point origin vector))]
       [to-y (get-y (transl-point origin vector))])
      (hyp from-z to-x to-y)) NL))

; Features
(define (row-triangles origin vector times)
  (define (helper curr-origin vector times-left string)
    (if (eq? times-left 0) string
      (let*
        ([new-origin (transl-point curr-origin vector)]
         [new-times-left (- times-left 1)]
         [base-height (get-z curr-origin)]
         [tri-string (triangle curr-origin vector base-height)]
         [new-string (string-append string tri-string)])
        (helper new-origin vector new-times-left new-string))))
  (helper origin vector times ""))

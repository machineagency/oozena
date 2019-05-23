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

; use -1 for no movement on a particular axis
(define (move-to point)
  (let*
    ([x-raw (get-x point)]
     [y-raw (get-y point)]
     [z-raw (get-z point)]
     [x-str (if (< 0 x-raw) "" (string-append
                                "X" (number->string x-raw) " "))]
     [y-str (if (< 0 y-raw) "" (string-append
                                "Y" (number->string y-raw) " "))]
     [z-str (if (< 0 z-raw) "" (string-append
                                "Z" (number->string z-raw) " "))])
  (string-append "G1" x-str y-str z-str)))

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

(define (hyp to-point)
  (string-append
    "G1 X" (number->string (get-x to-point))
    " Y" (number->string (get-y to-point))
    " Z" (number->string (get-z to-point))
    " E" (number->string HYP-EXT-RATE)
    " F" (number->string FEED-FAST)))

(define (transl-point origin vector)
  (let
    ([x (+ (get-x origin) (get-x vector))]
    [y (+ (get-y origin) (get-y vector))]
    [z (+ (get-z origin) (get-z vector))])
    (list x y z)))

(define (mul-vector vector scalar)
  (map (lambda (el) (+ el scalar)) vector))

(define (normalize vector)
  (let*
    ([squares (map (lambda (el) (* el el)) vector)]
     [norm (foldl + 0 squares)])
   (map (lambda (el) (/ el (sqrt norm))) vector)))

; Features (should have same signature)

(define (triangle origin vector base-height)
  (string-append
    (extrude-bead) NL
    (vertical base-height) NL
    (wait) NL
    (hyp (transl-point origin vector)) NL))

(define (bridge origin vector base-height)
  (let ([to-point (transl-point origin vector)])
    (string-append
      "G1 X" (number->string (get-x to-point))
      " Y" (number->string (get-y to-point))
      " E" (number->string BRIDGE-EXT-RATE)
      " F" (number->string FEED-FAST))))

(define (row shape-proc origin vector times)
  (define (helper curr-origin vector times-left string)
    (if (eq? times-left 0) string
      (let*
        ([new-origin (transl-point curr-origin vector)]
         [new-times-left (- times-left 1)]
         [base-height (get-z curr-origin)]
         [shape-string (shape-proc curr-origin vector base-height)]
         [new-string (string-append string shape-string)])
        (helper new-origin vector new-times-left new-string))))
  (helper origin (normalize vector) times ""))

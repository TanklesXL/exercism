#lang racket

(provide square total)
#|
    Calculations done using exponents where:
    square(X) == 2^(x-1)
    total() == sum of square(X) for X: 1->64 == (2^X)-1 
|#
(define (square num) (expt 2 (sub1 num)))
(define (total) (sub1 (square 65)))

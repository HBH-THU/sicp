#!/usr/bin/env chicken-scheme
(use debug sicp-eval test)

(with-primitive-procedures `((- ,-)
                             (= ,=))
  (lambda (env)
    (eval* '(define (iter x) (if (= x 0) x (iter (- x 1)))) env)
    (time (eval* '(iter 10000) env))))

(use sicp-eval-anal)

(with-primitive-procedures `((- ,-)
                             (= ,=))
  (lambda (env)
    (anal-eval* '(define (iter x) (if (= x 0) x (iter (- x 1)))) env)
    (time (anal-eval* '(iter 10000) env))))

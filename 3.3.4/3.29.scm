(load "the-agenda.scm")
(load "or-gate-compound.scm")
(load "make-wire.scm")
(load "probe.scm")
(load "set-signal!.scm")
(load "propagate.scm")

(define input-1 (make-wire))
(define input-2 (make-wire))
(define output (make-wire))

(probe 'output output)

(or-gate-compound input-1 input-2 output)

(set-signal! input-1 0)
(set-signal! input-2 0)
(propagate)

(set-signal! input-1 1)
(propagate)

;; Since (a | b) = ~(~a & ~b), that's one and-gate and three inversions.

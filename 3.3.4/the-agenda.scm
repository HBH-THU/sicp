(load "make-agenda.scm")

;; (define environment (the-environment))

;; (if (not (environment-bound? environment 'the-agenda))
;;     (begin
;;       (environment-define environment 'the-agenda (make-agenda))
;;       (write-line "defining"))
;;     (write-line "nicht defining"))

(define the-agenda (make-agenda))
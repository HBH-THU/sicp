(load "integral.scm")
(load "scale-stream.scm")
(load "add-streams.scm")

(define (RC R C dt)
  (lambda (i v_0)
    (let ((int (integral i v_0 dt)))
      (cons-stream v_0
                   (add-streams (scale-stream int (/ 1 C))
                                (scale-stream i R))))))
(define (try-kill assay test-name interval)
  (let ((result #!default))
    (let ((filum
           (create-thread
            #f (lambda () (set! result (assay))))))
      (register-timer-event
       interval
       (lambda () (kill-thread filum) (test-return test-name result))))))

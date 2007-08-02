(load-option 'regular-expression)
(load-option 'format)

(load "test.scm")
(load "eval-global.scm")
(load "install-packages.scm")

(install-packages)

(define expressions
  (list
   '(define count 0)
   '(define (id x)
      (set! count (+ count 1))
      x)
   '(define w (id (id 10)))
   'count
   'w
   'count))

(define lazy-side-effects
  (fold-right cons '() (map eval-global expressions)))

(test
 "lazy evaluation and side effects"
 "(ok ok ok 1 (thunk (id 10) (#.hash-table [0-9]*.)) 1)"
 lazy-side-effects
 're-string-match
 (lambda (expected got)
   (not (false? (re-string-match expected (format #f "~A" got))))))

(define (install-variable-package)
  (define (analyze-variable exp)
    (lambda (env succeed fail)
      (succeed (lookup-variable-value exp env)
               fail)))
  (put-amb 'variable analyze-variable)
  'done)
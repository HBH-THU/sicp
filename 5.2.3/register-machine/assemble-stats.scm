;;; Solutions copyright (C) 2007, Peter Danenberg; http://wizardbook.org
;;; Source code copyright (C) 1996, MIT; http://mitpress.mit.edu/sicp

(define (assemble controller-text machine)
  (extract-labels controller-text
    (lambda (insts labels)
      ((machine 'set-entry-points!) (map car labels))
      (update-insts! insts labels machine)
      insts)))
(define yachts
  '(define (yachts)
     (let ((mary-ann (amb 'moore 'downing 'hall 'hood 'parker)))
       ;; Given
       (require (eq? mary-ann 'moore))
       (let ((melissa (amb 'moore 'downing 'hall 'hood 'parker)))
         ;; Given
         (require (eq? melissa 'hood))
         (let ((rosalind (amb 'moore 'downing 'hall 'hood 'parker)))
           ;; Yacht's owner
           (require (not (eq? rosalind 'hall)))
           (let ((gabrielle (amb 'moore 'downing 'hall 'hood 'parker)))
             ;; Since Gabrielle's father owns Parker's daughter's yacht,
             ;; Gabrielle cannot be Parker's daughter.
             (require (not (eq? gabrielle 'parker)))
             (let ((lorna (amb 'moore 'downing 'hall 'hood 'parker)))
               ;; Lorna can't be Parker's daughter, because he's the
               ;; father of Melissa or Rosalind; Lorna also can't be
               ;; Hall's, because Melissa is already Hood's.
               (require (not (or (eq? lorna 'parker)
                                 (eq? lorna 'hall))))
               ;; One father per daughter
               (require (distinct? (list mary-ann melissa lorna rosalind gabrielle)))
               (list (list 'mary-ann mary-ann)
                     (list 'melissa melissa)
                     (list 'lorna lorna)
                     (list 'rosalind rosalind)
                     (list 'gabrielle gabrielle)))))))))
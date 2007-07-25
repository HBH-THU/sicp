(load "empty-agenda?.scm")
(load "first-segment.scm")
(load "segment-queue.scm")
(load "set-current-time!.scm")
(load "front-queue.scm")

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))
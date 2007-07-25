(load "first-segment.scm")
(load "rest-segments.scm")
(load "set-segments!.scm")
(load "delete-queue!.scm")
(load "empty-queue?.scm")

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))
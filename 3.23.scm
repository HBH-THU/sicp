#!/usr/bin/env chicken-scheme
(use srfi-1 srfi-69 test)

(define make-cell
  (case-lambda ((payload) (make-cell #f #f payload))
          ((forward backward payload)
           (cons* forward backward payload))))

(define cell-forward car)
(define cell-backward cadr)
(define cell-payload cddr)

(define (cell-set-forward! cell forward)
  (set-car! cell forward))
(define (cell-set-backward! cell backward)
  (set-car! (cdr cell) backward))
(define (cell-set-payload! cell payload)
  (set-cdr! (cdr cell) payload))

(define (cell->list front)
  (let iter ((cell (cell-backward front))
             (payloads '()))
    (if (eq? cell front)
        (cons (cell-payload cell) payloads)
        (iter (cell-backward cell)
              (cons (cell-payload cell) payloads)))))

(define (make-deque)
  (let ((front '())
        (rear '()))
    (define (empty?) (null? front))
    (lambda (message)
      (case message
        ((front)
         (if (empty?)
             (error "FRONT called with an empty deque.")
             (cell-payload front)))
        ((rear)
         (if (empty?)
             (error "REAR called with an empty deque.")
             (cell-payload rear)))
        ((front-insert!)
         (lambda (payload)
           (let ((cell (make-cell payload)))
             (when (empty?)
               (set! front cell)
               (set! rear cell))
             (cell-set-forward! cell front)
             (cell-set-backward! cell rear)
             (cell-set-backward! front cell)
             (cell-set-forward! rear cell)
             (set! front cell))))
        ((rear-insert!)
         (lambda (payload)
           (let ((cell (make-cell payload)))
             (when (empty?)
               (set! front cell)
               (set! rear cell))
             (cell-set-backward! cell rear)
             (cell-set-forward! cell front)
             (cell-set-forward! rear cell)
             (cell-set-backward! front cell)
             (set! rear cell))))
        ((front-delete!)
         (if (empty?)
             (error "FRONT-DELETE! called with empty deque.")
             (let ((new-front (cell-forward front)))
               (if (eq? front new-front)
                   ;; Deque is empty.
                   (begin
                     (set! front '())
                     (set! rear '()))
                   (begin
                     (cell-set-backward! new-front rear)
                     (cell-set-forward! rear new-front)
                     (set! front new-front))))))
        ((rear-delete!)
         (if (empty?)
             (error "REAR-DELETE! called with empty deque.")
             (let ((new-rear (cell-backward rear)))
               (if (eq? rear new-rear)
                   ;; Deque is empty.
                   (begin
                     (set! front '())
                     (set! rear '()))
                   (begin
                     (cell-set-backward! front new-rear)
                     (cell-set-forward! new-rear front)
                     (set! rear new-rear))))))
        ((->list) (if (empty?) '() (cell->list front)))))))

(let ((deque (make-deque)))
  (test '() (deque '->list))
  ((deque 'front-insert!) 'b)
  (test '(b) (deque '->list))
  ((deque 'front-insert!) 'a)
  (test '(a b) (deque '->list))
  ((deque 'rear-insert!) 'c)
  (test '(a b c) (deque '->list))
  (deque 'front-delete!)
  (test '(b c) (deque '->list))
  (deque 'rear-delete!)
  (test '(b) (deque '->list)))

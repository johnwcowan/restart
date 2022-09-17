(define tag-counter 0)

(define (make-restarter-tag)
  (set! tag-counter (+ tag-counter 1))
  (string->symbol
    (string-append
      "tag "
      (number->string tag-counter))))

(define-record-type <restarter>
  (make-restarter tag description invoker)
  restarter?
  (tag restarter-tag)
  (description restarter-description)
  (invoker restarter-invoker))

(define (restart restarter . args)
  (apply (restarter-invoker restarter) args))

(define ambient-restarters (make-parameter '()))

(define (with-restarter restarters thunk)
  (let ((restarters
        (if (pair? restarters) restarters (list restarters))))
    (parameterize
      ((ambient-restarters
       (append restarters ambient-restarters)))
      (thunk))))

(define (find-restarter tag restarters)
  (search-restarters tag (collect-restarters restarters)))

(define (search-restarters tag restarters)
  (cond
    ((null? restarters)
     #f)
    ((eqv? tag (restarter-tag (car restarters)))
     (car restarters))
    (else
      (search-restarters tag (cdr restarters)))))

(define (collect-restarters restarters)
  (delete-duplicates
    (lambda (x y)
      (eqv? (restarter-tag x) (restarter-tag y)))
    (append
      (normalize-restarters restarters)
      (ambient-restarters))))))

(define (normalize-restarters restarters)
  (cond
    ((pair? restarters)
     (search-restarters restarters))
    ((restarter? restarters)
     (list restarters))
    ((compound? restarters)
     (filter restarter? (compound-subobjects restarters)))))

(define interactor (make-parameterize default-interactor))

(define (restart-interactively restarters)
  ((interactor) (collect-restarters restarters)))


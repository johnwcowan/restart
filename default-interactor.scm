(define (default-interactor restarters)
  (for-each show-restarter (collect-restarters restarters))
  (display "Choose a restarter tag:")

(define (show-restarter restarter)
  (display (restarter-tag restarter))
  (display " - ")
  (display (car (restarter-description restarter)))
  (newline))

(define (choose-tag restarters)
  (call/cc
    (lambda (return)
      (let loop ((tag 

(define (read-restarter-tag restarters)
  (call/cc
    (lambda (return)
      (let retry ((tag
                  (string->symbol (read-line))))
              (display "unknown tag\n")))))))


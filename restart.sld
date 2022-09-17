(define-library (restart)

  (import (scheme base))

  (cond-expand
    ((library (srfi 222))
     (import (srfi 222)))
    (else
      (begin
        (define (compound? obj) #f)
        (define (compound-subobjects comp)
           '()))))

  (export make-restarter-tag make-restarter
          restarter? restarter-tag restarter-description
          restart ambient-restarters with-restarter
          find-restarter collect-restarters
          interactor restart-interactively)

  (include "default-interactor.scm")

  (include "restart.scm"))

;define builtin binary fxns
;--- b+ ---
(define builtin-+ +)
(define (b+ x y) (builtin-+ x y))
;--- b- ---
(define builtin-- -)
(define (b- x y) (builtin-- x y))
;--- b* ---
(define builtin-* *)
(define (b* x y) (builtin-* x y))
;--- b/ ---
(define builtin-/ /)
(define (b/ x y) (builtin-/ x y))
;--- b= ---
(define builtin-= =)
(define (b= x y) (builtin-= x y))
;--- b< ---
(define builtin-< <)
(define (b< x y) (builtin-< x y))
;all builtin binary fxns defined

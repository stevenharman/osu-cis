;initialization file for defining more Built-ins for Scheme
;
;--- n-ary addition (+) ---
(define (+ . l)
  (if (null? l) 0
    (b+ (car l) (apply + (cdr l)))))
;--- n-ary subtraction (-) ---
(define (- . l)
  (if (null? l) 0
      (b- (car l) (apply + (cdr l)))))
;--- n-ary multiply (*)
(define (* . l)
  (if (null? l) 1
      (b* (car l) (apply * (cdr l)))))
;--- n-ary divide (/) ---
(define (/ . l)
  (if (null? l) 1
      (b/ (car l) (apply / (cdr l)))))
;--- n-ary equal (=) ---
;--- n-ary lessthan (<) ---
;--- n-ary greaterthan (>) ---
;--- (<=) ---
;--- (>=) ---
;--- eqv? ---
;--- equal? ---
;--- zero? ---
;--- positive? ---
;--- negative? ---
;--- odd? ---
;--- even?
;--- not ---
;--- and ---
;--- or ---
;--- caar ---
;--- cadr ---
;--- caadr ---
;--- caaadr ---
;--- caaddr ---
;--- cadddr ---
;--- cddddr ---
;--- cdddar ---
;--- cddaar ---
;--- cdaaar ---
;--- caaaar ---
;--- memq ---
;--- memv ---
;--- member ---
;--- assq ---
;--- assv ---
;--- assoc ---
;--- map ---
;--- for-each ---
;--- End of ini.scm ---

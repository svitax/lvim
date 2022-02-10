;; lat? looks at each S-exprression in a liist, and asks if each
;; S-expression is an atom, until it runs out of S-expressions.
;; If it runs out without encountering a list, the value is #t
;; If it finds a list, the value is #f.
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

(lat? (bacon eggs))


(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (member? a (cdr lat)))))))

;; rember takes an atom and a lat as its arguments, and makes
;; a new lat with the first occurrence of the atom in the old
;; lat removed.
;; We compare each atom of the lat with the atom a, and if the
;; comparison fails we build a list that begings with the atom
;; we just compared.
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat)
                  (rember a (cdr lat)))))))


;; The function firsts takes one argument, a list, which is neither
;; a null list or contains only non-empty lists. It builds another
;; list composed of the first S-expression of each internal list.
(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (car l))
                  (firsts (cdr l)))))))

;; The function insertR builds a lat with new inserted to the
;; right of the first occurrence of old.
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old) (cons old (cons new (cdr lat))))
      (else (cons (car lat)
                  (insertR new old (cdr lat)))))))

;; The function insertL builds a list with new inserted to the
;; left of the first occurrence of old.
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old) (cons new lat))
      (else (cons (car lat)
                  (insertL new old (cdr lat)))))))

;; Replaces the first occurrence of old in the lat with new
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat (quote ())))
      ((eq? (car lat) old) (cons new (cdr lat)))
      (else (cons (car lat)
                  (subst new old (cdr lat)))))))

;; Replace either the first occurrence of old1 or
;; the first occurrence of old2 by new
(define subst2
  (lambda (new old1 old2 lat)
    (cond
      ((null? lat (quote ())))
      ((or (eq? (car lat) old1) (eq? (car lat) old2))
       (cons new (cdr lat)))
      (else (cons (car lat)
                  (subst2 new old1 old2 (cdr lat)))))))

;; The function multirember gives as its final value the lat
;; with all occurrences of 'a' removed
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a)
       (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons old
             (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))


(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new
             (cons old (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
       (cons new (multisubst new old (cdr lat))))
      (else (cons (car lat) (multisubst new old (cdr lat)))))))

;; Chapter 4
;; ---------------------------------------------------------------------
;; ---------------------------------------------------------------------
(define add1
  (lambda (n)
    (+ n 1)))

(define sub1
  (lambda (n)
    (- n 1)))

(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1 (o+ n (sub1 m)))))))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (sub1 (o- n (sub1 m)))))))

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (+ (car tup) (addtup (cdr tup)))))))

(define x
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (+ n (x n (sub1 m)))))))

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))

(define >
  (lambda (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (> (sub1 n) (sub1 m))))))

(define <
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else (< (sub1 n) (sub1 m))))))

(define =
  (lambda (n m)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else (= (sub1 n) (sub1 m))))))

(define =
  (lambda (n m)
    (cond
      ((> n m) #f)
      ((< n m) #f)
      (else #t))))

(define expt
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (* n (expt n (sub1 m)))))))

(define quotient
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (quotient (- n m) m))))))

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

;; The function no-nums gives as a final value a lat obtained by
;; removing all the numbers from the lat.
(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat))
       (no-nums (cdr lat)))
      (else (cons (car lat)
                  (no-nums (cdr lat)))))))

;; The functon all-nums extracts a tup from a lat using all the
;; numbers in the lat
(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) 
       (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

;; The function eqan? is true if its two arguments (a1 and a2)
;; are the same atom
(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2))
       (= a1 a2))
      ((or (number? a1) (number? a2))
       #f)
      (else (eq? a1 a2)))))

;; The functon occur counts the number of times an atom a appears
;; in a lat
(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? a (car lat)) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

;; The function one? is #t is n is 1 and #f otherwise
(define one?
  (lambda (n)
    (= n 1)))

;; Rewrite rempick using the one? function
(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat)
                  (rempick (sub1 n) (cdr lat)))))))

;; Chapter 5
;; ---------------------------------------------------------------------
;; ---------------------------------------------------------------------
(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (rember* a (cdr l)))
         (else (cons (car l)
                     (rember* a (cdr l))))))
      (else (cons (rember* a (car l))
                  (rember* a (cdr l)))))))

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
       (cond
         ((eq? old (car l))
          (cons old 
                (cons new 
                      (insertR* new old (cdr l)))))
         (else (cons (car l)
                     (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))))))

(define occcur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond ((eq? a (car l))
              (add1 (occur* a (cdr l))))
             (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l))
               (occur* a (cdr l)))))))

(define subst*
  (lambda (new old l)
    (cond ((null? l) 
           (quote ()))
          ((atom? (car l)) 
           (cond ((eq? (car l) old)
                  (cons new (subst* new old (cdr l))))
                 (else (cons (car l) (subst* new old (cdr l))))))
          (else (cons (subst* new old (car l))
                      (subst* new old (cdr l)))))))

(define insertL*
  (lambda (new old l)
    (cond ((null? l) (quote ()))
          ((atom? (car l)) (cond ((eq? old (car l))
                                  (cons new (cons old
                                                  (insertL* (cdr l)))))))
          (else (cons (insertL* new old (car l))
                      (insertL* new old (cdr l)))))))

(define member*
  (lambda (a l)
    (cond ((null? l) #f)
          ((atom? (car l))
           (or (eq? (car l) a)
               (member* a (cdr l))))
          (else (or (member* a (car l))
                    (member* a (cdr l)))))))

;; The function leftmost finds the leftmost atom in a non-empty
;; list of S-expressions that does not contain the empty list.

(define leftmost
  (lambda (l)
    (cond ((atom? (car l))
           (car l))
          (else (leftmost (car l))))))

(define eqlist?
  (lambda (l1 l2)
    (cond ((and (null? l1) (null? l2)) #t)
          ((or (null? l1) (null? l2)) #f)
          ((and (atom? (car l1)) (atom? (car l2)))
           (and (eqan? (car l1) (car l2))
                (eqlist? (cdr l1) (cdr l2))))
          ((or (atom? (car l1)) (atom? (car l2)))
           #f)
          (else (and (eqlist? (car l1) (car l2))
                     (eqlist? (cdr l1) (cdr l2)))))))

(define equal?
  (lambda (s1 s2)
    (cond ((and (atom? s1) (atom? s2))
           (eqan? s1 s2))
          ((or (atom? s1) (atom? s2))
           #f)
          (else (eqlist? s1 s2)))))

;; rember for list of s-expressions
(define rember
  (lambda (s l)
    (cond ((null? l) (quote ()))
          ((equal? (car l) s) (cdr l))
          (else (cons (car l)
                      (rember s (cdr l)))))))

;; Chapter 6
;; ---------------------------------------------------------------------
;; ---------------------------------------------------------------------

;; An arithmetic expression is either an atom (including numbers),
;; or two arithmetic expressions combined by +, x, or ^

(quote a) ;; the atom a
(quote +) ;; the atom +, not the operation +
(quote *) ;; the atom *, not the operation *

(eq? (quote a) y)

(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))

(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))

(define operator
  (lambda (aexp)
    (car aexp)))

(define value
  (lambda (nexp)
    (cond ((atom? nexp) nexp)
          ((eq? (operator nexp) (quote +))
           (+ (value (1st-sub-exp nexp))
              (value (2nd-sub-exp nexp))))
          ((eq? (operator nexp) (quote *))
           (* (value (1st-sub-exp nexp))
              (value (2nd-sub-exp nexp))))
          (else (^ (value (1st-sub-exp nexp))
                   (value (2nd-sub-exp nexp)))))))

;; Chapter 7
;; ---------------------------------------------------------------------
;; ---------------------------------------------------------------------

(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else (cons (car lat)
                  (makeset (multirember (car lat) (cdr lat))))))))

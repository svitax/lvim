; Recursive factorial
(fn fact [n]
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

; Iterative factorial
(fn fact [n]
  (fn fact-iter [acc n]
    (if (= n 0)
        acc
        (fact-iter (* n acc) (- n 1))))
  (fact-iter 1 n))

; Threading macro (racket syntax)
(require threading)
(fn fact [n]
  (~> (range 1 (+ n 1))
      (foldl * 1 _)))


; Recursive fibonacci
(fn fib [n]
  (match n
    0 0
    1 1
    _ (+ (fib (- n 1)) (fib (- n 2)))))

; Iterative fibonacci
(fn fib [n]
  (fib-iter 1 0 n))

(fn fib-iter [a b count]
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

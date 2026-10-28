#set text(size: 13pt)
= Empirical Runtime Extrapolation for Naive Fibonacci

The naive recursive Fibonacci function `fib(n)` has asymptotic time complexity $T(n) in Theta(phi^n)$, where the golden ratio is $phi = frac(1 + sqrt(5), 2) approx 1.618$ (note that $phi^5 approx 11.09$).

Suppose running `fib(35)` takes *$2.0$ seconds* on your machine. Approximately how long will `fib(40)` take on the same machine?
#pagebreak()
#set text(size: 13pt)
$22$ seconds
#pagebreak()
#set text(size: 13pt)
$3.2$ seconds
#pagebreak()
#set text(size: 13pt)
$10$ seconds
#pagebreak()
#set text(size: 13pt)
$64$ seconds

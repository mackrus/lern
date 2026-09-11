#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $z = x + i y$ with $x > 0$:
$ |f_n(z)| = |e^(-n(x + i y))| = e^(-n x). $
For any fixed $z$ with $x > 0$, $e^(-n x) -> 0$ as $n -> oo$, so pointwise convergence to $0$ holds.
However, for uniform convergence on $S = {"Re"(z) > 0}$, we must consider the supremum:
$ sup_(x > 0) e^(-n x) = lim_(x -> 0^+) e^(-n x) = 1. $
Since this supremum is $1$ for every $n$ and does not tend to $0$, convergence is not uniform on ${"Re"(z) > 0}$.
(Note: on ${"Re"(z) >= a}$ for $a > 0$, the supremum is $e^(-n a) -> 0$, which is uniformly convergent).

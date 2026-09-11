#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

We apply the inequality between arithmetic and geometric means:
$ n^3 + x^(2n) >= 2 sqrt(n^3 dot x^(2n)) = 2 n^(3/2) |x|^n. $
Therefore, for all $x in RR$ and all $n >= 1$:
$ | x^n / (n^3 + x^(2n)) | = (|x|^n) / (n^3 + x^(2n)) <= (|x|^n) / (2 n^(3/2) |x|^n) = 1 / (2 n^(3/2)). $
Notice that $M_n = 1 / (2 n^(3/2))$ is independent of $x$.
The numerical series $sum_(n=1)^oo M_n = 1/2 sum_(n=1)^oo 1 / n^(3/2)$ converges because $p = 3/2 > 1$.
By the Weierstrass M-test, the series converges uniformly on all of $RR$.

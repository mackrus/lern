#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $K subset {"Re"(z) > 0}$ be any compact subset. Then there exists $delta > 0$ such that $"Re"(z) >= delta$ for all $z in K$.
On $K$:
$ |e^(-n^2 z)| = e^(-n^2 "Re"(z)) <= e^(-n^2 delta) = (e^(-delta))^(n^2). $
For $n >= 1$, $n^2 >= n$, so $e^(-n^2 delta) <= (e^(-delta))^n$.
Since $e^(-delta) < 1$, the geometric series $sum (e^(-delta))^n$ converges, so $sum e^(-n^2 delta)$ converges.
By the Weierstrass M-test, the series converges uniformly on $K$.
Since each term $e^(-n^2 z)$ is entire (and thus analytic), by the Weierstrass theorem on analytic functions, the sum of a locally uniformly convergent series of analytic functions is analytic in ${"Re"(z) > 0}$.

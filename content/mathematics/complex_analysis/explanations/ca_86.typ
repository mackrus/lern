#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $z_k = 1 / k$. Then $k = 1 / z_k$.
Express the right-hand side in terms of $z_k$:
$ (k + k^2) / (1 + k^2) = (1/z_k + 1/z_k^2) / (1 + 1/z_k^2) = ((z_k + 1) / z_k^2) / ((z_k^2 + 1) / z_k^2) = (z_k + 1) / (z_k^2 + 1). $
Consider the rational function $g(z) = (z + 1) / (z^2 + 1)$.
The poles of $g(z)$ are at $z = plus.minus i$, which lie on the boundary $|z| = 1$.
Thus $g(z)$ is analytic in the open unit disk $|z| < 1$.
For all $k = 2, 3, dots$, we have $f(1/k) = g(1/k)$.
The sequence of points $z_k = 1/k$ has an accumulation point at $0$, which lies inside the domain $|z| < 1$.
By the Identity Theorem, $f(z) = g(z)$ for all $z in D(0, 1)$.
Thus $f(z) = (z + 1) / (z^2 + 1)$.

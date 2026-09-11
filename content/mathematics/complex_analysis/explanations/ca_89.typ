#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $|z| > 1$, write the argument of the logarithm as:
$ (z - i) / (z + i) = (1 - i/z) / (1 + i/z). $
Since $|i / z| = 1 / |z| < 1$, both factors lie in the domain of the principal logarithm:
$ "Log"((z - i) / (z + i)) = "Log"(1 - i/z) - "Log"(1 + i/z). $
Using the Maclaurin series $"Log"(1 + w) = sum_(k=1)^oo (-1)^(k-1) w^k / k$:
$ "Log"(1 - i/z) = - sum_(k=1)^oo (i / z)^k / k $
$ "Log"(1 + i/z) = sum_(k=1)^oo (-1)^(k-1) (i / z)^k / k. $
Subtracting them:
$ "Log"(1 - i/z) - "Log"(1 + i/z) = - 2 sum_(k "odd") (i / z)^k / k. $
Let $k = 2 n + 1$ for $n >= 0$. Since $i^(2 n + 1) = i (i^2)^n = i (-1)^n$:
$ - 2 (i (-1)^n) / (2 n + 1) 1 / z^(2 n + 1) = 2 i (-1)^(n+1) / (2 n + 1) 1 / z^(2 n + 1). $
Thus $f(z) = 2 i sum_(n=0)^oo (-1)^(n+1) / (2 n + 1) 1 / z^(2 n + 1)$.

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Rewrite the equation as $c z^n - e^z = 0$.
Choose $f(z) = c z^n$ and $g(z) = -e^z$.
On the unit circle $C: |z| = 1$:
$ |f(z)| = |c z^n| = |c| |z|^n = |c| > e. $
For $g(z) = -e^z$, with $z = x + i y$ and $|z| = 1$ (meaning $-1 <= x <= 1$):
$ |g(z)| = |-e^z| = |e^(x + i y)| = e^x <= e^1 = e. $
Therefore, along $|z| = 1$:
$ |g(z)| <= e < |c| = |f(z)|. $
By Rouché's Theorem, $f(z) + g(z) = c z^n - e^z$ has the same number of zeros inside $|z| < 1$ as $f(z) = c z^n$.
Since $f(z)$ has an $n$-th order zero at $z = 0$, there are exactly $n$ roots inside the unit circle.

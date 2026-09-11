#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

We apply Rouché's Theorem on the unit circle $|z| = 1$.
Let $F(z) = z^2$ and $G(z) = e^(z - 1)$.
On $|z| = 1$:
$ |F(z)| = |z|^2 = 1. $
For $G(z)$, write $z = x + i y$. On the circle $|z| = 1$, $x <= 1$, and since $z eq.not 1$ almost everywhere, let us check the bound:
$ |G(z)| = |e^(x + i y - 1)| = e^(x - 1). $
Since $|z| = 1$, $-1 <= x <= 1$.
At $x = 1$ (the point $z = 1$), $|F(1)| = 1$ and $|G(1)| = e^0 = 1$. The equality $|F| = |G|$ at $z = 1$ requires taking a slightly modified contour or checking $|z| = 1 + epsilon$.
On $|z| = 1$, $f(1) = 1^2 + e^0 = 2 eq.not 0$, so there are no zeros on the boundary.
On the circle $|z| = 1$, for all $z eq.not 1$, $x < 1$, so $e^(x - 1) < 1 = |z^2|$.
Alternatively, consider $|z| = R$ with $R = 1.1$: $|z^2| = 1.21$, while $|e^(z - 1)| <= e^(1.1 - 1) = e^(0.1) approx 1.105 < 1.21$.
Thus $|z^2| > |e^(z - 1)|$ on $|z| = 1.1$.
Since $z^2$ has exactly $2$ zeros (a double zero at $0$) inside $|z| < 1.1$, and there are no zeros in $1 <= |z| < 1.1$, $f(z)$ has exactly $2$ zeros inside $|z| < 1$.

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

We apply Rouché's Theorem on the boundary contour $C: |z| = 1$.
Decompose $P(z) = f(z) + g(z)$ where:
$ f(z) = -5z^4, quad g(z) = z^6 + z^3 - 2z. $
Along $|z| = 1$:
$ |f(z)| = |-5z^4| = 5|z|^4 = 5. $
$ |g(z)| = |z^6 + z^3 - 2z| <= |z|^6 + |z|^3 + 2|z| = 1 + 1 + 2 = 4. $
Since $|g(z)| = 4 < 5 = |f(z)|$ everywhere on $|z| = 1$, Rouché's Theorem asserts that $f(z)$ and $f(z) + g(z) = P(z)$ have the same number of zeros inside $|z| = 1$.
The function $f(z) = -5z^4$ has a zero of multiplicity 4 at $z = 0$, which is inside $|z| < 1$.
Therefore, $P(z)$ has exactly 4 zeros inside $|z| < 1$.

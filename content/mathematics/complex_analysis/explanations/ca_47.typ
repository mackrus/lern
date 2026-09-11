#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The circle $|z - 1| = 1$ intersects the real axis at $z = 0$ and $z = 2$.
Since $T$ maps the upper half plane onto itself, the real axis is mapped to the real axis, meaning the coefficients can be chosen real.
The circle is mapped to the imaginary axis, which intersects the real axis at $0$ and $oo$.
Thus the set {0, 2} must be mapped to {0, oo}.
If $T(0) = 0$ and $T(2) = oo$, then $T(z) = k z / (2 - z)$ for some real $k$.
We are given $T(1 + i) = i$:
$ T(1 + i) = k (1 + i) / (2 - (1 + i)) = k (1 + i) / (1 - i) = k i (1 - i) / (1 - i) = k i. $
Thus $k i = i arrow.r.double k = 1$.
Hence $T(z) = z / (2 - z)$ (or $T(z) = (z - 2) / z$ in the alternate orientation).

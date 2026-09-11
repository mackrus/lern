#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The integrand has simple poles where $1 + z^2 = 0$, namely $z = i$ and $z = -i$.
Check which poles lie inside the contour $|z - i / 2| = 1$:
- For $z = i$: $|i - i / 2| = |i / 2| = 1/2 < 1$ (inside).
- For $z = -i$: $|-i - i / 2| = |- 3 i / 2| = 3/2 > 1$ (outside).
Thus, only the simple pole at $z = i$ lies inside $gamma$.
By Cauchy's Integral Formula or Residue Theorem:
$ integral_gamma (1 / (z + i)) / (z - i) thin d z = 2 pi i dot [ 1 / (z + i) ]_(z = i) = 2 pi i dot 1 / (2 i) = pi. $

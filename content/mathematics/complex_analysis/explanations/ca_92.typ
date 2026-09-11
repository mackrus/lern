#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The poles of $1 / (z^2 + 1)^4 = 1 / ((z - i)^4 (z + i)^4)$ are at $z = i$ and $z = -i$, each of order $4$.
The rectangle vertices are $2, 2 + 2i, -2 + 2i, -2$, which covers $x in [-2, 2]$ and $y in [0, 2]$.
- The pole $z = i$ ($x = 0, y = 1$) lies strictly inside the rectangle.
- The pole $z = -i$ ($x = 0, y = -1$) lies strictly outside the rectangle.
Thus, we only need the residue at $z = i$.
Write $f(z) = phi(z) / (z - i)^4$ where $phi(z) = (z + i)^(-4)$.
By the residue formula for a pole of order $4$:
$ "Res"_(z=i) f(z) = 1 / (3!) phi'''(i). $
Compute derivatives of $phi(z) = (z + i)^(-4)$:
$ phi'(z) = -4 (z + i)^(-5) $
$ phi''(z) = 20 (z + i)^(-6) $
$ phi'''(z) = -120 (z + i)^(-7). $
Evaluating at $z = i$ where $z + i = 2 i$:
$ phi'''(i) = -120 (2 i)^(-7) = -120 / (128 i^7) = -120 / (128 (-i)) = 120 / (128 i) = - i dot 15 / 16. $
Thus:
$ "Res"_(z=i) f(z) = 1/6 ( - i dot 15/16 ) = - i dot 5/32. $
By the Residue Theorem:
$ integral_gamma f(z) d z = 2 pi i ( - i dot 5/32 ) = 2 pi (- i^2) dot 5/32 = (10 pi) / 32 = (5 pi) / 16. $

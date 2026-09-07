#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The roots of $z^4 = -4 = 4 e^(i (pi + 2 k pi))$ are:
$ z_k = sqrt(2) e^(i (pi/4 + k pi / 2)) quad (k = 0, 1, 2, 3). $
Evaluating:
- $k = 0: sqrt(2)(1/sqrt(2) + i/sqrt(2)) = 1 + i$
- $k = 1: sqrt(2)(-1/sqrt(2) + i/sqrt(2)) = -1 + i$
- $k = 2: sqrt(2)(-1/sqrt(2) - i/sqrt(2)) = -1 - i$
- $k = 3: sqrt(2)(1/sqrt(2) - i/sqrt(2)) = 1 - i$

Pairing conjugate roots to form real quadratic factors:
$ (z - (1 + i))(z - (1 - i)) = ((z - 1) - i)((z - 1) + i) = (z - 1)^2 + 1 = z^2 - 2z + 2. $
$ (z - (-1 + i))(z - (-1 - i)) = ((z + 1) - i)((z + 1) + i) = (z + 1)^2 + 1 = z^2 + 2z + 2. $
Thus, $z^4 + 4 = (z^2 - 2z + 2)(z^2 + 2z + 2)$.

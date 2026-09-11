#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

A Möbius transformation is completely determined by the cross-ratio:
$ (w, w_1, w_2, w_3) = (z, z_1, z_2, z_3). $
Here, $z_1 = i, z_2 = oo, z_3 = 1$ and $w_1 = 0, w_2 = 1, w_3 = -i$.
The cross-ratio with a point at infinity is:
$ (z, i, oo, 1) = (z - i) / (1 - i). $
For the target points:
$ (w, 0, 1, -i) = ((w - 0)(1 - (-i))) / ((w - (-i))(1 - 0)) = (w (1 + i)) / (w + i). $
Equating the two cross-ratios:
$ (w (1 + i)) / (w + i) = (z - i) / (1 - i). $
To find $T(0)$, set $z = 0$:
$ (w (1 + i)) / (w + i) = (0 - i) / (1 - i) = - i / (1 - i) = (-i (1 + i)) / 2 = (1 - i) / 2. $
Cross-multiplying:
$ 2 w (1 + i) = (1 - i)(w + i) = w (1 - i) + i (1 - i) = w (1 - i) + (1 + i). $
$ w [2(1 + i) - (1 - i)] = 1 + i arrow.r.double w (1 + 3 i) = 1 + i. $
Wait, let's solve $T(z)$ directly: $T(z) = (a z + b)/(c z + d)$.
$T(i) = 0 arrow.r.double a i + b = 0 arrow.r.double b = - a i$.
$T(oo) = 1 arrow.r.double a / c = 1 arrow.r.double c = a$.
So $T(z) = (a z - a i) / (a z + d) = (z - i) / (z + d/a)$.
$T(1) = -i arrow.r.double (1 - i) / (1 + d/a) = -i arrow.r.double 1 - i = -i(1 + d/a) = -i - i d/a arrow.r.double 1 = - i d/a arrow.r.double d/a = i$.
Thus $T(z) = (z - i) / (z + i)$.
Evaluating at $z = 0$: $T(0) = -i / i = -1$.

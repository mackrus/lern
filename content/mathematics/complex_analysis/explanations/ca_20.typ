#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider $f(z) = z / ((z^2 + 1)(z^2 + 2z + 2))$ along the standard semicircular contour in the upper half-plane ($"Im"(z) > 0$).
Poles of $f(z)$:
- From $z^2 + 1 = 0$: $z = plus.minus i$ $arrow.r$ in upper half-plane: $z_1 = i$.
- From $z^2 + 2z + 2 = (z + 1)^2 + 1 = 0$: $z = -1 plus.minus i$ $arrow.r$ in upper half-plane: $z_2 = -1 + i$.

Calculate residues at these two simple poles in the upper half-plane:
1. At $z_1 = i$:
   $ "Res"_(z=i) f(z) = i / ((2i)(i^2 + 2i + 2)) = 1 / (2(-1 + 2i + 2)) = 1 / (2(1 + 2i)) = (1 - 2i) / (2(1 + 4)) = (1 - 2i) / 10. $
2. At $z_2 = -1 + i$:
   $ "Res"_(z=-1+i) f(z) = (-1 + i) / (((-1+i)^2 + 1)(2(-1+i) + 2)) = (-1 + i) / ((1 - 2i - 1 + 1)(2i)) = (-1 + i) / ((1 - 2i)(2i)) = (-1 + i) / (2i + 4) = (-1 + i)(4 - 2i) / 20 = (-4 + 2i + 4i + 2) / 20 = (-2 + 6i) / 20 = (-1 + 3i) / 10. $
Sum of residues:
$ Sigma "Res" = (1 - 2i) / 10 + (-1 + 3i) / 10 = (i) / 10. $
By the Residue Theorem:
$ "P.V." integral_(-oo)^oo f(x) d x = 2 pi i Sigma "Res" = 2 pi i (i / 10) = (2 pi i^2) / 10 = - (2 pi) / 10 = - pi / 5. $

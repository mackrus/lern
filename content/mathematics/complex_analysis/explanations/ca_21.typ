#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Substitute $z = e^(i theta)$ along the unit circle $C: |z| = 1$. Then:
$ cos theta = (z + z^(-1)) / 2 = (z^2 + 1) / (2z), quad d theta = (d z) / (i z). $
The integral becomes:
$ integral_C 1 / (1 + a (z^2 + 1)/(2z)) (d z) / (i z) = integral_C 2 / (2z + a z^2 + a) (d z) / i = 2/i integral_C 1 / (a z^2 + 2z + a) thin d z. $
Roots of $a z^2 + 2z + a = 0$ (for $a eq.not 0$):
$ z = (-2 plus.minus sqrt(4 - 4a^2)) / (2a) = (-1 plus.minus sqrt(1 - a^2)) / a. $
Since the product of roots is $z_1 z_2 = 1$, exactly one root lies inside $|z| < 1$, namely $z_1 = (-1 + sqrt(1 - a^2)) / a$.
The residue of $1 / (a z^2 + 2z + a)$ at $z_1$ is:
$ "Res" = 1 / (2 a z_1 + 2) = 1 / (2(-1 + sqrt(1 - a^2)) + 2) = 1 / (2 sqrt(1 - a^2)). $
By the Residue Theorem:
$ integral_0^(2 pi) 1 / (1 + a cos theta) thin d theta = 2/i dot 2 pi i dot 1 / (2 sqrt(1 - a^2)) = (2 pi) / sqrt(1 - a^2). $

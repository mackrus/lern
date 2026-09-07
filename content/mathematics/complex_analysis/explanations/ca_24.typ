#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider $f(z) = (z e^(i a z)) / (z^4 + 4)$. The target integral is $"Im"[ integral_(-oo)^oo f(x) d x ]$.
Poles are roots of $z^4 = -4 = 4 e^(i pi)$, which are $z = 1 plus.minus i$ and $-1 plus.minus i$.
The poles in the upper half-plane are $z_1 = 1 + i$ and $z_2 = -1 + i$.
At any simple pole $z_k$ of $z^4 + 4$:
$ "Res"_(z=z_k) (z e^(i a z)) / (z^4 + 4) = (z_k e^(i a z_k)) / (4 z_k^3) = (z_k^2 e^(i a z_k)) / (4 z_k^4) = (z_k^2 e^(i a z_k)) / (4(-4)) = - (z_k^2 e^(i a z_k)) / 16. $
1. For $z_1 = 1 + i$: $z_1^2 = 2i$, $i a z_1 = -a + i a$, so:
   $ "Res"_1 = - (2i e^(-a + i a)) / 16 = - i / 8 e^(-a) (cos a + i sin a) = e^(-a) / 8 (sin a - i cos a). $
2. For $z_2 = -1 + i$: $z_2^2 = -2i$, $i a z_2 = -a - i a$, so:
   $ "Res"_2 = - (-2i e^(-a - i a)) / 16 = i / 8 e^(-a) (cos a - i sin a) = e^(-a) / 8 (sin a + i cos a). $
Sum of residues:
$ Sigma "Res" = e^(-a) / 8 [ (sin a - i cos a) + (sin a + i cos a) ] = (2 e^(-a) sin a) / 8 = (e^(-a) sin a) / 4. $
By the Residue Theorem:
$ integral_(-oo)^oo (x e^(i a x)) / (x^4 + 4) d x = 2 pi i ((e^(-a) sin a) / 4) = i pi / 2 e^(-a) sin a. $
Taking the imaginary part gives $pi / 2 e^(-a) sin a$.

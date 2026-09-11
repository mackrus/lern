#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The denominator $z(z - 1)^2(z + 1)^2$ has poles at $z = 0$ (simple), $z = 1$ (double), and $z = -1$ (double).
All three poles lie strictly inside the circle $|z| = 4$.
1. Residue at $z = 0$:
$ "Res"_(z=0) = [ e^(i z) / (z^2 - 1)^2 ]_(z=0) = e^0 / (-1)^2 = 1. $
2. Residue at $z = 1$ (pole of order 2):
Let $g(z) = e^(i z) / (z(z + 1)^2)$. Then $"Res"_(z=1) = g'(1)$.
$ g'(z) = (i e^(i z) z (z+1)^2 - e^(i z) ((z+1)^2 + 2 z(z+1))) / (z^2 (z+1)^4) = (e^(i z) (i z(z+1) - (z+1) - 2 z)) / (z^2 (z+1)^3). $
At $z = 1$:
$ g'(1) = (e^i (2 i - 2 - 2)) / (1 dot 8) = (e^i (2 i - 4)) / 8 = e^i (i - 2) / 4. $
3. Residue at $z = -1$ (pole of order 2):
Similarly, for $h(z) = e^(i z) / (z(z - 1)^2)$ at $z = -1$:
$ h'(-1) = e^(-i) (-i - 2) / 4. $
Adding the residues at $z = 1$ and $z = -1$:
$ 1/4 [ (i - 2) e^i + (-i - 2) e^(-i) ] = 1/4 [ -2 (e^i + e^(-i)) + i (e^i - e^(-i)) ] = 1/4 [ -4 cos 1 - 2 sin 1 ] = - cos 1 - 1/2 sin 1. $
Sum of all three residues:
$ Sigma "Res" = 1 - cos 1 - 1/2 sin 1. $
Multiplying by $2 pi i$ gives $2 pi i (1 - cos 1 - 1/2 sin 1)$.

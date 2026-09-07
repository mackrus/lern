#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The function $f(z) = p(z) / q(z)$ where $p(z) = e^z$ and $q(z) = z^2 + pi^2$.
At $z_0 = pi i$:
$ p(pi i) = e^(pi i) = -1 eq.not 0, quad q(pi i) = (pi i)^2 + pi^2 = -pi^2 + pi^2 = 0. $
Since $q'(z) = 2z$, we have $q'(pi i) = 2 pi i eq.not 0$, so $z = pi i$ is a simple pole.
The residue formula for $p(z)/q(z)$ at a simple pole gives:
$ "Res"_(z=pi i) f(z) = (p(pi i)) / (q'(pi i)) = (-1) / (2 pi i) = (-1 dot (-i)) / (2 pi i dot (-i)) = i / (2 pi). $

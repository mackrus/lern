#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the complex function $f(z) = ("Log"(z)) / (z^2 + 9)$ with branch cut along the negative imaginary axis, using $-\pi / 2 < "arg"(z) < (3 pi) / 2$.
Integrate along the upper half plane boundary with an indented semicircular contour around the origin:
- On the positive real axis: $z = x$, $f(x) = (ln x) / (x^2 + 9)$.
- On the negative real axis: $z = -t$ ($t > 0$), so $"Log"(z) = ln t + i pi$. Then:
$ integral_(-oo)^0 ("Log"(x)) / (x^2 + 9) thin d x = integral_0^oo (ln t + i pi) / (t^2 + 9) thin d t = integral_0^oo (ln x) / (x^2 + 9) thin d x + i pi integral_0^oo d x / (x^2 + 9). $
Sum of both real line integrals:
$ 2 integral_0^oo (ln x) / (x^2 + 9) thin d x + i pi dot pi / 6. $
In the upper half plane, $f(z)$ has a simple pole at $z = 3 i = 3 e^(i pi / 2)$:
$ "Res"_(z = 3 i) = ("Log"(3 i)) / (2(3 i)) = (ln 3 + i pi / 2) / (6 i) = - i / 6 ln 3 + pi / 12. $
By the Residue Theorem:
$ 2 I + i (pi^2 / 6) = 2 pi i ( - i / 6 ln 3 + pi / 12 ) = pi / 3 ln 3 + i (pi^2 / 6). $
Equating the real parts:
$ 2 I = pi / 3 ln 3 arrow.r.double I = pi / 6 ln 3. $

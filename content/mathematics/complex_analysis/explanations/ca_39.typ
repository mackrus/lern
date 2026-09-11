#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider $(1 - i) f(z) = (1 - i)(u + i v) = (u + v) + i(v - u)$.
Since $f$ is analytic, $F(z) = (1 - i) f(z)$ is analytic with real part $U = u + v = x y$.
Since $U$ is the real part of an analytic function, it must be harmonic: $U_(x x) + U_(y y) = 0 + 0 = 0$, which holds.
Now find the harmonic conjugate $V$ of $U = x y$:
$ V_y = U_x = y arrow.r.double V = 1/2 y^2 + h(x) $
$ V_x = - U_y = - x arrow.r.double h'(x) = - x arrow.r.double h(x) = - 1/2 x^2 + c_0. $
Thus $V = 1/2 (y^2 - x^2) + c_0$.
Then $F(z) = U + i V = x y + i / 2 (y^2 - x^2) + i c_0 = - i / 2 (x + i y)^2 + i c_0 = - i / 2 z^2 + i c_0$.
Now recover $f(z)$:
$ f(z) = (F(z)) / (1 - i) = (1 + i) / 2 [ - i / 2 z^2 + i c_0 ] = (1 - i) / 4 (z^2 + C) $ where $C = -2 c_0 in RR$.

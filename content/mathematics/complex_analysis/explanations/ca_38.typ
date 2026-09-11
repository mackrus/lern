#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

To be a harmonic conjugate, $v$ must satisfy the Cauchy-Riemann equations:
$ v_y = u_x = 2 x $
$ v_x = - u_y = -(- 2 y) = 2 y. $
Integrating $v_y = 2 x$ with respect to $y$ gives:
$ v(x, y) = 2 x y + h(x). $
Differentiating with respect to $x$:
$ v_x = 2 y + h'(x). $
Comparing with $v_x = 2 y$, we obtain $h'(x) = 0$, so $h(x) = C in RR$.
Therefore, $v(x, y) = 2 x y + C$. Note that $u + i v = (x^2 - y^2 + 2 i x y) + 5 + i C = z^2 + 5 + i C$, which is entire.

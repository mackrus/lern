#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Since $u$ is the real part of an analytic function, it must be harmonic: $u_(x x) + u_(y y) = 0$.
Compute partial derivatives:
$ u_x = 3 x^2 + g(y) arrow.r.double u_(x x) = 6 x $
$ u_y = x g'(y) arrow.r.double u_(y y) = x g''(y). $
Laplace's equation requires:
$ 6 x + x g''(y) = 0 arrow.r.double x(6 + g''(y)) = 0. $
This must hold for all $x$, so $g''(y) = -6$.
Integrating twice:
$ g'(y) = -6 y + 2 a arrow.r.double g(y) = -3 y^2 + 2 a y + b, quad a, b in RR. $
Thus $u(x, y) = x^3 - 3 x y^2 + 2 a x y + b x = "Re"(z^3 + i a z^2 + b z)$.
Adding an arbitrary imaginary constant $i c$ gives:
$ f(z) = z^3 + i a z^2 + b z + i c, quad a, b, c in RR. $

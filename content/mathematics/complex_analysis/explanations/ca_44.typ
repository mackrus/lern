#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

From $u_x = -u$, we know $f'(z) = u_x + i v_x$. By Cauchy-Riemann, $v_x = -u_y$.
Since $u$ is harmonic, $u_(x x) + u_(y y) = 0$. Using $u_x = -u$, we have $u_(x x) = - u_x = u$.
Thus $u_(y y) = - u_(x x) = - u$.
The general solution to $u_(x x) = u$ and $u_(y y) = -u$ with $u_x = -u$ is:
$ u(x, y) = e^(-x) (A cos y + B sin y), quad A, B in RR. $
Notice that:
$ e^(-z) = e^(-x - i y) = e^(-x)(cos y - i sin y) $
$ i e^(-z) = e^(-x)(sin y + i cos y). $
Therefore, $"Re"(a e^(-z)) = e^(-x)(A cos y + B sin y)$ where $a = A - i B in CC$.
Since $f(z)$ is uniquely determined up to an imaginary constant by its real part:
$ f(z) = a e^(-z) + i b, quad a in CC, b in RR. $

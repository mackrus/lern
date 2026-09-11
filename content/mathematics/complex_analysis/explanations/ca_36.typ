#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

If $|f(z)| = 0$, then $f(z) equiv 0$, which is constant.
If $|f(z)| = c > 0$, then $|f(z)|^2 = u^2 + v^2 = c^2$.
Differentiating with respect to $x$ and $y$:
$ 2 u u_x + 2 v v_x = 0 quad "and" quad 2 u u_y + 2 v v_y = 0. $
Applying the Cauchy-Riemann equations $u_y = - v_x$ and $v_y = u_x$ to the second equation:
$ - u v_x + v u_x = 0. $
We have a linear system for $(u_x, v_x)$:
$ mat(u, v; v, -u) vec(u_x, v_x) = vec(0, 0). $
The determinant is $- (u^2 + v^2) = - c^2 eq.not 0$.
Hence $u_x = 0$ and $v_x = 0$. By Cauchy-Riemann, $v_y = u_x = 0$ and $u_y = - v_x = 0$.
Since all partials vanish on the domain $D$, $f(z)$ is constant.

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $f = u + i v$ to be analytic, $u$ and $v$ must satisfy the Cauchy-Riemann equations:
1. $v_y = u_x = 2 - 2y$.
   Integrating with respect to $y$:
   $ v(x, y) = 2y - y^2 + g(x). $
2. $v_x = -u_y = -(-2x) = 2x$.
   Differentiating our expression for $v$ with respect to $x$:
   $ v_x = g'(x) = 2x arrow.r g(x) = x^2 + C. $
Therefore, $v(x, y) = x^2 - y^2 + 2y + C$.

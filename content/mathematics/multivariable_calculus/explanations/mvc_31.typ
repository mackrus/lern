#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Using the chain rule with the coordinates $u = x^3 - y$ and $v = x$, the PDE simplifies to $(partial z) / (partial v) = v(v^3 - u) = v^4 - u v$. Integrating with respect to $v$ gives $z(u, v) = 1/5 v^5 - 1/2 u v^2 + g(u)$, which translates to $z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^3 - y)$.

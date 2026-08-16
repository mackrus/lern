#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Using the multivariable chain rule, we transform the PDE in terms of $x$ and $y$. The equation simplifies to $(partial f) / (partial x) = x$. Integrating with respect to $x$ yields $f(x, y) = 1/2 x^2 + g(y)$, and substituting back the original variables gives $f(s, t) = 1/2 (s^2 - t^2)^2 + g(2 s t)$.

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Solve the partial differential equation
$ (partial z) / (partial x) + 3 x^2 (partial z) / (partial y) = x y $
by using the change of variables $u = x^3 - y$, $v = x$. (Here $g$ is an arbitrary differentiable function).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^3 - y) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z(x, y) = 1/5 x^5 - 1/2 (x^3 - y) x^2 + g(x^3 - y) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z(x, y) = -3/10 x^5 + 1/2 x y^2 + g(x^3 - y) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z(x, y) = -3/10 x^5 + 1/2 x^2 y + g(x^2 - y) $

#expl_page(include "../explanations/mvc_31.typ")
#formulae_page(include "../formulae/mvc_31.typ")
#steps_page(include "../solution_steps/mvc_31.typ")
#prereq_page(include "../prerequisites/mvc_31.typ")

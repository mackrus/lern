#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Given the harmonic function $u(x, y) = 2x(1 - y) = 2x - 2x y$, find a harmonic conjugate $v(x, y)$ such that $f(z) = u + i v$ is analytic.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x^2 - y^2 + 2y + C $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -x^2 + y^2 - 2y + C $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2x y - y^2 + C $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x^2 + y^2 - 2x + C $

#expl_page(include "../explanations/ca_08.typ")
#formulae_page(include "../formulae/ca_08.typ")
#steps_page(include "../solution_steps/ca_08.typ")
#prereq_page(include "../prerequisites/ca_08.typ")

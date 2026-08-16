#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Compute the directional derivative $D_bold(u) f(0, 0)$ in the direction of a unit vector $bold(u) = (u_1, u_2)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (u_1 - u_2)^3 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ u_1 - u_2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (u_1 - u_2) / (u_1^2 + u_2^2) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ u_1^3 - u_2^3 $

#expl_page(include "../explanations/mvc_16.typ")
#formulae_page(include "../formulae/mvc_16.typ")
#steps_page(include "../solution_steps/mvc_16.typ")
#prereq_page(include "../prerequisites/mvc_16.typ")

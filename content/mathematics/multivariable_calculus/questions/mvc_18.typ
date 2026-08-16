#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Consider the curve in $RR^3$ defined by the system of equations:
$ x^2 + y^3 + z^4 = 3 $
$ x y + x z + y z = 3 $
Near the point $(1, 1, 1)$, $x$ and $y$ are parameterized by $z$. Compute the derivatives $d x / d z$ and $d y / d z$ at $(1, 1, 1)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ d x / d z = 1, #h(1em) d y / d z = -2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ d x / d z = -1, #h(1em) d y / d z = 2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ d x / d z = 1, #h(1em) d y / d z = 2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ d x / d z = 2, #h(1em) d y / d z = -2 $

#expl_page(include "../explanations/mvc_18.typ")
#formulae_page(include "../formulae/mvc_18.typ")
#steps_page(include "../solution_steps/mvc_18.typ")
#prereq_page(include "../prerequisites/mvc_18.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $x in RR$ and matrix $A$ given by:
$ A = mat(x, x, x, x; 1, x, x, x; 2, 2, x, x; 0, 2, -1, x) $
Compute the determinant $det(A)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x(x - 1)(x - 2)(x + 1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x(x - 1)(x + 2)(x + 1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -x(x - 1)(x - 2)(x + 1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x^2(x - 1)(x - 2) $

#expl_page(include "../explanations/mvc_25.typ")
#formulae_page(include "../formulae/mvc_25.typ")
#steps_page(include "../solution_steps/mvc_25.typ")
#prereq_page(include "../prerequisites/mvc_25.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find and classify all critical points of the function $f(x, y) = x^2 + 2 y^2 + x^2 y$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (0, 0) text(" is a local minimum, ") (2, -1) text(" and ") (-2, -1) text(" are saddle points") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (0, 0) text(" is a local maximum, ") (2, -1) text(" and ") (-2, -1) text(" are saddle points") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (0, 0) text(" is a local minimum, ") (2, -1) text(" is a saddle point, ") (-2, -1) text(" is a local maximum") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (0, 0) text(" is a saddle point, ") (2, -1) text(" and ") (-2, -1) text(" are local minima") $

#expl_page(include "../explanations/mvc_32.typ")
#formulae_page(include "../formulae/mvc_32.typ")
#steps_page(include "../solution_steps/mvc_32.typ")
#prereq_page(include "../prerequisites/mvc_32.typ")

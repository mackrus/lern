#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y, z) = x^2 y + y z^2 + z x^2$.

Compute the gradient of $f$ at the point $P(1, -1, 2)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 2, 5, -3 chevron.r $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 2, -5, 3 chevron.r $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 1, -1, 2 chevron.r $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 2, 5, 3 chevron.r $

#expl_page(include "../explanations/mvc_01.typ")
#formulae_page(include "../formulae/mvc_01.typ")
#steps_page(include "../solution_steps/mvc_01.typ")
#prereq_page(include "../prerequisites/mvc_01.typ")

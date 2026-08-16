#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $T$ be the linear transformation in $RR^3$ that reflects with respect to a line $l$ that goes through the origin. Suppose $T(1, 2, 3) = (-3, -2, 1)$. Find a directional vector for the line $l$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l -1, 0, 2 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 1, 2, 3 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l -3, -2, 1 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ chevron.l 1, 0, 2 chevron.r $

#expl_page(include "../explanations/mvc_10.typ")
#formulae_page(include "../formulae/mvc_10.typ")
#steps_page(include "../solution_steps/mvc_10.typ")
#prereq_page(include "../prerequisites/mvc_10.typ")

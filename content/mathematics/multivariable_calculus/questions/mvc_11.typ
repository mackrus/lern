#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $T$ be the linear transformation in $RR^3$ that reflects with respect to a line $l$ that goes through the origin. Suppose $T(1, 2, 3) = (-3, -2, 1)$. Find the standard matrix $[T]$ of $T$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(-3/5, 0, -4/5; 0, -1, 0; -4/5, 0, 3/5) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(3/5, 0, 4/5; 0, 1, 0; 4/5, 0, -3/5) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(-3/5, 0, 4/5; 0, -1, 0; 4/5, 0, 3/5) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(-1, 0, 0; 0, -1, 0; 0, 0, 1) $

#expl_page(include "../explanations/mvc_11.typ")
#formulae_page(include "../formulae/mvc_11.typ")
#steps_page(include "../solution_steps/mvc_11.typ")
#prereq_page(include "../prerequisites/mvc_11.typ")

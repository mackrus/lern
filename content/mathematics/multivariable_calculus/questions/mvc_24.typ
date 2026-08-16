#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $T: RR^2 -> RR^2$ be a linear transformation with standard matrix:
$ [T] = mat(1/5, -2/5; -2/5, 4/5) $
Find the standard matrix of the composition transformation $T compose T$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(1/5, -2/5; -2/5, 4/5) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(1, 0; 0, 1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(1/25, 4/25; 4/25, 16/25) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(2/5, -4/5; -4/5, 8/5) $

#expl_page(include "../explanations/mvc_24.typ")
#formulae_page(include "../formulae/mvc_24.typ")
#steps_page(include "../solution_steps/mvc_24.typ")
#prereq_page(include "../prerequisites/mvc_24.typ")

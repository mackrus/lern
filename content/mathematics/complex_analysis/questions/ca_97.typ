#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For $0 < a < 1$, evaluate the integral:
$ integral_0^oo d x / (x^a (1 + x)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / sin(pi a)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / cos(pi a)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 pi) / sin(pi a)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1 / sin(pi a)$

#expl_page(include "../explanations/ca_97.typ")
#formulae_page(include "../formulae/ca_97.typ")
#steps_page(include "../solution_steps/ca_97.typ")
#prereq_page(include "../prerequisites/ca_97.typ")

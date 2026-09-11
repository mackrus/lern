#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For constants $a > 0$ and $b > 0$, evaluate the integral:
$ integral_(-oo)^oo (cos(a x)) / (x^2 + b^2) thin d x $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / b e^(-a b)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 pi) / b e^(-a b)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / b^2 e^(-a b)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi e^(-a b)$

#expl_page(include "../explanations/ca_96.typ")
#formulae_page(include "../formulae/ca_96.typ")
#steps_page(include "../solution_steps/ca_96.typ")
#prereq_page(include "../prerequisites/ca_96.typ")

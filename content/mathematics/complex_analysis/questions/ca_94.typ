#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the improper integral:
$ integral_0^oo d x / (1 + x^2)^3 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(3 pi) / 16$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / 4$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(5 pi) / 32$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / 8$

#expl_page(include "../explanations/ca_94.typ")
#formulae_page(include "../formulae/ca_94.typ")
#steps_page(include "../solution_steps/ca_94.typ")
#prereq_page(include "../prerequisites/ca_94.typ")

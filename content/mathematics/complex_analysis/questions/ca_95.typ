#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Calculate the definite trigonometric integral:
$ integral_0^(2 pi) d theta / (2 + cos theta)^2 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(4 pi) / (3 sqrt(3))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 pi) / sqrt(3)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(4 pi) / 3$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / sqrt(3)$

#expl_page(include "../explanations/ca_95.typ")
#formulae_page(include "../formulae/ca_95.typ")
#steps_page(include "../solution_steps/ca_95.typ")
#prereq_page(include "../prerequisites/ca_95.typ")

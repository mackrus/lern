#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Evaluate the definite trigonometric integral for $-1 < a < 1$:
$ integral_0^(2 pi) 1 / (1 + a cos theta) thin d theta $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (2 pi) / sqrt(1 - a^2) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (2 pi) / (1 - a^2) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (pi) / sqrt(1 - a^2) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (2 pi a) / sqrt(1 - a^2) $

#expl_page(include "../explanations/ca_21.typ")
#formulae_page(include "../formulae/ca_21.typ")
#steps_page(include "../solution_steps/ca_21.typ")
#prereq_page(include "../prerequisites/ca_21.typ")

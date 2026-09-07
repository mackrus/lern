#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the *principal value* of the complex power $(1 + i)^i$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ e^(-pi / 4) [cos(1/2 ln 2) + i sin(1/2 ln 2)] $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ e^(pi / 4) [cos(1/2 ln 2) + i sin(1/2 ln 2)] $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ e^(-pi / 4) [cos(ln 2) - i sin(ln 2)] $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ e^(-pi / 2) [cos(1/2 ln 2) + i sin(1/2 ln 2)] $

#expl_page(include "../explanations/ca_06.typ")
#formulae_page(include "../formulae/ca_06.typ")
#steps_page(include "../solution_steps/ca_06.typ")
#prereq_page(include "../prerequisites/ca_06.typ")

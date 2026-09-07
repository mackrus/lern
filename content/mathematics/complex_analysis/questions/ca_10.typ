#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $C_R$ be the upper half of the circle $|z| = R$ ($R > 2$), oriented counterclockwise. Using the $M L$-inequality, what is a rigorous upper bound for $|integral_(C_R) (2z^2 - 1)/(z^4 + 5z^2 + 4) thin d z|$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (pi R (2R^2 + 1)) / ((R^2 - 1)(R^2 - 4)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (2 pi R (2R^2 - 1)) / (R^4 + 5R^2 + 4) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (pi R) / (R^2 - 4) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (2 pi) / (R^2 - 1) $

#expl_page(include "../explanations/ca_10.typ")
#formulae_page(include "../formulae/ca_10.typ")
#steps_page(include "../solution_steps/ca_10.typ")
#prereq_page(include "../prerequisites/ca_10.typ")

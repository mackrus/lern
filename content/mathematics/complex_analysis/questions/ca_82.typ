#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all zeros and their respective orders for the entire function:
$ f(z) = sinh^2 z + cosh^2 z $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = i (pi / 4 + (k pi) / 2), quad k in ZZ$, each with order $1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = i (pi / 2 + k pi), quad k in ZZ$, each with order $2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = pi / 4 + k pi, quad k in ZZ$, each with order $1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = plus.minus i pi / 2$, each with order $1$

#expl_page(include "../explanations/ca_82.typ")
#formulae_page(include "../formulae/ca_82.typ")
#steps_page(include "../solution_steps/ca_82.typ")
#prereq_page(include "../prerequisites/ca_82.typ")

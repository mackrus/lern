#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all complex solutions $z$ to the equation:
$ cos z = 2 i $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = plus.minus (pi / 2 - i ln(2 + sqrt(5))) + 2 k pi, quad k in ZZ$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = pi / 2 + i ln(2 + sqrt(5)) + 2 k pi, quad k in ZZ$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = plus.minus i ln(2 + sqrt(5)) + 2 k pi, quad k in ZZ$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z = pi / 2 - i ln 2 + k pi, quad k in ZZ$

#expl_page(include "../explanations/ca_34.typ")
#formulae_page(include "../formulae/ca_34.typ")
#steps_page(include "../solution_steps/ca_34.typ")
#prereq_page(include "../prerequisites/ca_34.typ")

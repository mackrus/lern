#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the exact region of convergence in $CC$ of the power series:
$ sum_(n=1)^oo (z + i)^n / n^2 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$|z + i| <= 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$|z + i| < 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$|z - i| < 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
All $z in CC$

#expl_page(include "../explanations/ca_77.typ")
#formulae_page(include "../formulae/ca_77.typ")
#steps_page(include "../solution_steps/ca_77.typ")
#prereq_page(include "../prerequisites/ca_77.typ")

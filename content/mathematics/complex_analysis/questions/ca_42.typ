#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine all analytic functions of the form:
$ f(z) = a_1 x + a_2 y + a_3 x^2 + a_4 x y + a_5 y^2 + a_6 x^3 + a_7 y^3 $
where $a_1, dots, a_7 in CC$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a z + b z^2, quad a, b in CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a z + b z^2 + c z^3, quad a, b, c in CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a z^2, quad a in CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a (x + i y)^3, quad a in CC$

#expl_page(include "../explanations/ca_42.typ")
#formulae_page(include "../formulae/ca_42.typ")
#steps_page(include "../solution_steps/ca_42.typ")
#prereq_page(include "../prerequisites/ca_42.typ")

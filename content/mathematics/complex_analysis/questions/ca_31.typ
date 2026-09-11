#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Which of the following demonstrates the identity $e^(overline(z)) = overline(e^z)$ for any $z = x + i y in CC$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x - i y) = e^x (cos y - i sin y) = overline(e^x (cos y + i sin y))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x - i y) = - e^x (cos y + i sin y) = - e^z$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x - i y) = e^(-x) (cos y + i sin y) = 1 / e^z$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x - i y) = e^x (sin y - i cos y) = - i overline(e^z)$

#expl_page(include "../explanations/ca_31.typ")
#formulae_page(include "../formulae/ca_31.typ")
#steps_page(include "../solution_steps/ca_31.typ")
#prereq_page(include "../prerequisites/ca_31.typ")

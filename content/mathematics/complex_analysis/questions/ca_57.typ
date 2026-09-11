#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a function $phi(x, y)$ harmonic in the semi-disk $Omega = D(0, 1) inter {"Im"(z) > 0}$ that takes value $1$ on the diameter boundary $(-1, 1)$ and $0$ on the semicircular boundary.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((1 - x^2 - y^2) / (2 y))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((2 y) / (1 - x^2 - y^2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan(y / (1 - x^2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 - x^2 - y^2$

#expl_page(include "../explanations/ca_57.typ")
#formulae_page(include "../formulae/ca_57.typ")
#steps_page(include "../solution_steps/ca_57.typ")
#prereq_page(include "../prerequisites/ca_57.typ")

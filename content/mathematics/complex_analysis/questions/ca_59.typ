#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine a harmonic function $phi(x, y)$ in the first quadrant $x > 0, y > 0$ with boundary value $1$ on the interval $(1, 2)$ of the positive real axis and $0$ elsewhere on the boundary.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((5 x^2 - 5 y^2 - 4 - (x^2 + y^2)^2) / (6 x y)) + 1/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((x y) / (x^2 + y^2 - 4))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((2 x) / (y (x^2 + y^2)))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi [arctan(y / (x - 2)) - arctan(y / (x - 1))]$

#expl_page(include "../explanations/ca_59.typ")
#formulae_page(include "../formulae/ca_59.typ")
#steps_page(include "../solution_steps/ca_59.typ")
#prereq_page(include "../prerequisites/ca_59.typ")

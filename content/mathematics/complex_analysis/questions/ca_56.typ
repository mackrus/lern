#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine a harmonic function $phi(x, y)$ in the interior of the unit disk with boundary value $1$ on $partial D(0, 1) inter {| "arg"(z) | < pi / 4}$ and $0$ on $partial D(0, 1) inter {pi / 4 < | "arg"(z) | <= pi}$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((x^2 + y^2 - 2 sqrt(2) x + 1) / (x^2 + y^2 - 1)) + 1/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((2 x y) / (x^2 + y^2 - 1))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((sqrt(2) x) / (1 - x^2 - y^2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / (2 pi) arctan((x + y) / (1 - x y)) + 1/4$

#expl_page(include "../explanations/ca_56.typ")
#formulae_page(include "../formulae/ca_56.typ")
#steps_page(include "../solution_steps/ca_56.typ")
#prereq_page(include "../prerequisites/ca_56.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the harmonic function $phi(x, y)$ in the unit disk $D(0, 1)$ with boundary values $1$ on $partial D(0, 1) inter {"Re"(z) > 0}$ and $0$ on $partial D(0, 1) inter {"Re"(z) < 0}$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((2 x) / (1 - x^2 - y^2)) + 1/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((2 y) / (1 - x^2 - y^2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan(x / (1 - y^2)) + 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / (2 pi) ln((1 + x) / (1 - x))$

#expl_page(include "../explanations/ca_55.typ")
#formulae_page(include "../formulae/ca_55.typ")
#steps_page(include "../solution_steps/ca_55.typ")
#prereq_page(include "../prerequisites/ca_55.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a harmonic function $phi(x, y)$ in the semi-infinite strip $Omega = {"Re"(z) > 0} inter {0 < "Im"(z) < pi}$ with boundary values $1$ on $z = i y$ ($0 < y < pi$) and $0$ on the horizontal boundaries $y = 0$ and $y = pi$ ($x > 0$).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((sin y) / (sinh x))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 2 / pi arctan((cos y) / (cosh x))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = 1 / pi arctan((sinh x) / (sin y))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$phi(x, y) = e^(-x) sin y$

#expl_page(include "../explanations/ca_58.typ")
#formulae_page(include "../formulae/ca_58.typ")
#steps_page(include "../solution_steps/ca_58.typ")
#prereq_page(include "../prerequisites/ca_58.typ")

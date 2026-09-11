#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine all analytic functions $f = u + i v$ for which $u(x, y) = x^3 + x g(y)$, where $g$ is a twice continuously differentiable real function.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = z^3 + i a z^2 + b z + i c, quad a, b, c in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = z^3 + a z^2 + b z + c, quad a, b, c in CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = z^3 - 3 x y^2 + i c, quad c in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = x^3 - 3 x y^2 + i (3 x^2 y - y^3)$

#expl_page(include "../explanations/ca_43.typ")
#formulae_page(include "../formulae/ca_43.typ")
#steps_page(include "../solution_steps/ca_43.typ")
#prereq_page(include "../prerequisites/ca_43.typ")

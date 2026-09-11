#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Suppose that both $f(z) = u(x, y) + i v(x, y)$ and its complex conjugate $overline(f(z)) = u(x, y) - i v(x, y)$ are analytic on a connected domain $D$. What can be concluded about $f$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ is identically constant in $D$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ must be a purely imaginary function

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a z + b$ for some real constants $a, b$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f'(z)$ is a non-zero constant in $D$

#expl_page(include "../explanations/ca_35.typ")
#formulae_page(include "../formulae/ca_35.typ")
#steps_page(include "../solution_steps/ca_35.typ")
#prereq_page(include "../prerequisites/ca_35.typ")

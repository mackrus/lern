#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Expand $f(z) = 1 / (z^2 + 2 z)$ in a Laurent series in the annular region $1 < |z - i| < sqrt(5)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1/2 sum_(n=0)^oo (-i)^n / (z - i)^(n+1) + 1/2 sum_(n=0)^oo (- 1 / (2 + i))^(n+1) (z - i)^n$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = sum_(n=0)^oo (-1)^n / (z - i)^n$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1/2 sum_(n=0)^oo (z - i)^n / 5^n$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = sum_(n=0)^oo i^n (z - i)^n$

#expl_page(include "../explanations/ca_88.typ")
#formulae_page(include "../formulae/ca_88.typ")
#steps_page(include "../solution_steps/ca_88.typ")
#prereq_page(include "../prerequisites/ca_88.typ")

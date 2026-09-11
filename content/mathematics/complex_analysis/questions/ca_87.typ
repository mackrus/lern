#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the Laurent series expansion of $f(z) = 1 / (z (1 + z^2)(4 - z^2))$ valid in the unbounded region $|z| > 2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1/5 sum_(n=0)^oo ((-1)^n - 4^n) 1 / z^(2 n + 3)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1/5 sum_(n=0)^oo ((-1)^n + 4^n) 1 / z^(2 n + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = sum_(n=0)^oo (-1)^n / z^(2 n + 3)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1/4 sum_(n=0)^oo z^(2 n - 1) / 4^n$

#expl_page(include "../explanations/ca_87.typ")
#formulae_page(include "../formulae/ca_87.typ")
#steps_page(include "../solution_steps/ca_87.typ")
#prereq_page(include "../prerequisites/ca_87.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find the Laurent series expansion of $f(z) = "Log"((z - i) / (z + i))$ valid in the region $|z| > 1$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 2 i sum_(n=0)^oo (-1)^(n+1) / (2 n + 1) 1 / z^(2 n + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 2 sum_(n=0)^oo 1 / (2 n + 1) 1 / z^(2 n + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = - 2 i sum_(n=0)^oo 1 / (n + 1) 1 / z^(n + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = i sum_(n=0)^oo (-1)^n / z^(2 n)$

#expl_page(include "../explanations/ca_89.typ")
#formulae_page(include "../formulae/ca_89.typ")
#steps_page(include "../solution_steps/ca_89.typ")
#prereq_page(include "../prerequisites/ca_89.typ")

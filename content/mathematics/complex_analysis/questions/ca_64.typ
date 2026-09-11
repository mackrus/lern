#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the value of the integral:
$ integral_gamma (z^2 sin z + |z + 3/4| + e^(sin z) cos z + 1 / (z (z + 1))) thin d z $
where $gamma$ is the curve $z(t) = (2 e^(2 pi i t) - 3) / 4$ for $0 <= t <= 1$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$- 2 pi i$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$- pi i$

#expl_page(include "../explanations/ca_64.typ")
#formulae_page(include "../formulae/ca_64.typ")
#steps_page(include "../solution_steps/ca_64.typ")
#prereq_page(include "../prerequisites/ca_64.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a conformal mapping which transforms the cut plane $CC without [0, oo)$ onto the interior of the unit disk $|w| < 1$, such that the point $-4$ is mapped to the origin.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z^(1/2) - 2 i) / (z^(1/2) + 2 i), quad "where" "Im"(z^(1/2)) > 0$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z^(1/2) - 4) / (z^(1/2) + 4)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z - 4 i) / (z + 4 i)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (sqrt(z) - 2) / (sqrt(z) + 2)$

#expl_page(include "../explanations/ca_53.typ")
#formulae_page(include "../formulae/ca_53.typ")
#steps_page(include "../solution_steps/ca_53.typ")
#prereq_page(include "../prerequisites/ca_53.typ")

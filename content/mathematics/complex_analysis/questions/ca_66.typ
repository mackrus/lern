#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the integral:
$ integral_gamma d z / (z^2 - 4) $
where $gamma$ is the arc $z(t) = e^(i t)$ for $0 <= t <= (3 pi) / 2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/4 (ln 3 + 2 i arctan(1/2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/4 ln 3$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$i / 2 arctan(1/2)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / 4 (1 + i)$

#expl_page(include "../explanations/ca_66.typ")
#formulae_page(include "../formulae/ca_66.typ")
#steps_page(include "../solution_steps/ca_66.typ")
#prereq_page(include "../prerequisites/ca_66.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the contour integral:
$ integral_gamma d z / (1 + z^2) $
where $gamma$ is the positively oriented circle $|z - i / 2| = 1$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi$

#expl_page(include "../explanations/ca_61.typ")
#formulae_page(include "../formulae/ca_61.typ")
#steps_page(include "../solution_steps/ca_61.typ")
#prereq_page(include "../prerequisites/ca_61.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the value of the contour integral:
$ integral_(|z|=4) e^(i z) / (z (z^2 - 1)^2) thin d z $
traversed counterclockwise.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i (1 - cos 1 - 1/2 sin 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i (1 - cos 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i (sin 1 + 1/2 cos 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi i (1 - e^i)$

#expl_page(include "../explanations/ca_93.typ")
#formulae_page(include "../formulae/ca_93.typ")
#steps_page(include "../solution_steps/ca_93.typ")
#prereq_page(include "../prerequisites/ca_93.typ")

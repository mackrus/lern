#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Using de Moivre's formula $(cos theta + i sin theta)^4 = cos(4 theta) + i sin(4 theta)$, determine the expression for $cos(4 theta)$ in terms of $cos theta$ and $sin theta$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$cos^4 theta - 6 cos^2 theta sin^2 theta + sin^4 theta$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$cos^4 theta - 4 cos^2 theta sin^2 theta + sin^4 theta$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$4 cos^3 theta sin theta - 4 cos theta sin^3 theta$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$cos^4 theta + 6 cos^2 theta sin^2 theta + sin^4 theta$

#expl_page(include "../explanations/ca_30.typ")
#formulae_page(include "../formulae/ca_30.typ")
#steps_page(include "../solution_steps/ca_30.typ")
#prereq_page(include "../prerequisites/ca_30.typ")

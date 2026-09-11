#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

A Möbius transformation $T$ maps the upper half plane onto itself, and maps the circle $|z - 1| = 1$ onto the imaginary axis such that $1 + i$ maps to $i$. What is $T(z)$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = z / (2 - z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (z - 1) / (z + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (2 z) / (z - 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 + z) / (1 - z)$

#expl_page(include "../explanations/ca_47.typ")
#formulae_page(include "../formulae/ca_47.typ")
#steps_page(include "../solution_steps/ca_47.typ")
#prereq_page(include "../prerequisites/ca_47.typ")

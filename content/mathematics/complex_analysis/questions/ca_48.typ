#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Which Möbius transformation maps the exterior of the unit circle $|z| > 1$ onto the left half plane $"Re"(w) < 0$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 + z) / (1 - z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (z - 1) / (z + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (i z + 1) / (z - i)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 - z) / (1 + z)$

#expl_page(include "../explanations/ca_48.typ")
#formulae_page(include "../formulae/ca_48.typ")
#steps_page(include "../solution_steps/ca_48.typ")
#prereq_page(include "../prerequisites/ca_48.typ")

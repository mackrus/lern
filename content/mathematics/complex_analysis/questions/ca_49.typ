#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the Möbius transformation $T(z)$ which maps the region bounded by $|z - 1 + 2i| < 2 sqrt(2)$, $|z - 1 - 2i| < 2 sqrt(2)$, and $|z| > 1$ onto the circular triangle with vertices at $0, 1, i$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 + i) / 2 dot (3 - z) / (1 + z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 - i) / 2 dot (z - 3) / (z + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (3 - z) / (1 + z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (1 + i) (z - 1) / (z + 2)$

#expl_page(include "../explanations/ca_49.typ")
#formulae_page(include "../formulae/ca_49.typ")
#steps_page(include "../solution_steps/ca_49.typ")
#prereq_page(include "../prerequisites/ca_49.typ")

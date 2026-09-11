#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a Möbius transformation $T(z)$ which maps the disk $|z - i| < 2$ onto the upper half plane, maps the imaginary axis onto itself, and fixes the point $i$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = - i (z + i) / (z - 3 i)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (z - i) / (z + i)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = i (z - 2) / (z + 2)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$T(z) = (z + 3 i) / (z - i)$

#expl_page(include "../explanations/ca_46.typ")
#formulae_page(include "../formulae/ca_46.typ")
#steps_page(include "../solution_steps/ca_46.typ")
#prereq_page(include "../prerequisites/ca_46.typ")

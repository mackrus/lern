#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

The Pythagorean identity $sin^2 x + cos^2 x = 1$ is known to hold for all real numbers $x in RR$. Why does it follow that $sin^2 z + cos^2 z = 1$ for all complex numbers $z in CC$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
The function $g(z) = sin^2 z + cos^2 z - 1$ is entire and vanishes on $RR$, which has accumulation points in $CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $sin^2 z + cos^2 z$ is a bounded function on $CC$, so Liouville's theorem applies

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $sin z$ and $cos z$ are periodic with period $2 pi$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
By Cauchy's integral formula applied along the unit circle

#expl_page(include "../explanations/ca_83.typ")
#formulae_page(include "../formulae/ca_83.typ")
#steps_page(include "../solution_steps/ca_83.typ")
#prereq_page(include "../prerequisites/ca_83.typ")

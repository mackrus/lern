#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
It is possible to combine the speed of light $c$, the mass of an electron $m_e$, and Planck's constant $planck$ to obtain a quantity measured in seconds.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The quantity is $planck / (m_e c^2)$.
#prereq_page([
#include "../prerequisites/core/prac_plancks_radiation_law.typ"
])

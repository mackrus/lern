#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A spin-1 system is in the state $ bar.v psi chevron.r = A(bar.v 1,1 chevron.r + 2 bar.v 1,0 chevron.r + 2i bar.v 1,-1 chevron.r) $. Given $A=1/3$, find the expectation value $chevron.l S_z chevron.r$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$-1/3 planck$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/3 planck$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$planck$
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

$chevron.l S_z chevron.r = sum p_m m planck = 1/9(1) + 4/9(0) + 4/9(-1) = -3/9 planck = -1/3 planck$.
#pagebreak()
#include "prerequisites/spin_1_systems.typ"

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A spin-1 system is in the state $ bar.v psi chevron.r = A(bar.v 1,1 chevron.r + 2 bar.v 1,0 chevron.r + 2i bar.v 1,-1 chevron.r) $. Determine the normalization constant $A$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/3$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/sqrt(5)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/9$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/5$
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

$bar.v A bar.v^2 (1^2 + 2^2 + bar.v 2i bar.v^2) = A^2(1+4+4) = 9 A^2 = 1 => A = 1/3$.
#pagebreak()
#include "../prerequisites/spin_1_systems.typ"

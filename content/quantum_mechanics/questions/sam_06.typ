#import "../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A particle has orbital angular momentum $l=1$ and spin $s=1/2$. What are the possible values for the total angular momentum quantum number $j$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/2, 3/2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0, 1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$3/2, 5/2$
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

$j = bar.v l - s bar.v, dots, l + s = bar.v 1 - 1/2 bar.v, 1 + 1/2 = 1/2, 3/2$.
#pagebreak()
#include "../prerequisites/spin_angular_momentum.typ"

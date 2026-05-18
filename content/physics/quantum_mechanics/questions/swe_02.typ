#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A particle in an infinite square well of width $a$ is in state $psi(x,t) = i/2 psi_1 e^(-i E_1 t / planck) - 1/2 psi_2 e^(-i E_2 t / planck) + 1/sqrt(2) psi_3 e^(-i E_3 t / planck)$. What is the probability of measuring the energy to be $E_2$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/4$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/sqrt(2)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
0
#pagebreak()
#include "../explanations/swe_02.typ"
#pagebreak()
#include "../prerequisites/conceptual_practice.typ"

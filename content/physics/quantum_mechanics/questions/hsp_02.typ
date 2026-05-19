#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
An electron in a hydrogen atom is in the normalized wavefunction $ psi(r, theta, phi) = A sqrt(r) e^(-r/a) $. How was it possible in principle to know what the wave function was at $t=t_0$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
By performing a measurement of an observable for which $psi$ is an eigenstate
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
By waiting for the system to reach thermal equilibrium
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
By cooling the system to absolute zero
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
It is impossible to know the exact wave function
#expl_page(include "../explanations/hsp_02.typ")
#prereq_page([
#include "../prerequisites/core/hs_state_preparation.typ"
])

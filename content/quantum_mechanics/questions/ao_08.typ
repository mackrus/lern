#import "../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a 2D Hydrogen-like atom described by the Schrödinger equation in polar coordinates $(r, phi)$. For the radial part $F(r)$, if we assume an expansion $F(r) = P(r)e^(-kappa r)$, what is the requirement on $P(r)$ to ensure a normalizable state?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$P(r)$ must be a finite polynomial
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$P(r)$ must be a sine function
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$P(r)$ must go to infinity as $r -> 0$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$P(r)$ must be constant
#pagebreak()
#include "../explanations/ao_08.typ"
#pagebreak()
#include "../prerequisites/atoms_orbitals.typ"

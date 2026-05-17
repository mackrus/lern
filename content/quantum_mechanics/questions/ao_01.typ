#import "../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a 2D Hydrogen-like atom described by the Schrödinger equation in polar coordinates $(r, phi)$. After performing separation of variables $Psi = F(r)Y(phi)$, what is the form of the angular equation?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$d^2 Y / d phi^2 = - m^2 Y$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$d^2 Y / d phi^2 = - l(l+1) Y$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$d Y / d phi = i m Y$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$d^2 Y / d phi^2 = 0$
#pagebreak()
#include "../explanations/ao_01.typ"
#pagebreak()
#include "../prerequisites/atoms_orbitals.typ"

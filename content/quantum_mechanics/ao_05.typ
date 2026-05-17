#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a 2D Hydrogen-like atom described by the Schrödinger equation in polar coordinates $(r, phi)$. What are the physical periodic boundary conditions for the angular part $Y(phi)$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$Y(phi) = Y(phi + 2pi)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$Y(phi) = Y(phi + pi)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$Y(0) = 0$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$Y'(0) = 0$
#pagebreak()
#include "prerequisites/atoms_orbitals.typ"

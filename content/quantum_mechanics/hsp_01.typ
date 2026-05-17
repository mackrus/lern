#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
An electron in a hydrogen atom is in the normalized wavefunction $ psi(r, theta, phi) = A sqrt(r) e^(-r/a) $. Determine the normalization constant $A$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$sqrt(2 / (3 pi a^4))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$sqrt(1 / (pi a^4))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$sqrt(3 / (pi a^4))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/a^2$
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Normalization requires $1 = integral bar.v psi bar.v^2 r^2 sin(theta) d r d theta d phi$. The radial integral is $integral_0^infinity r^3 e^(-2r/a) d r = 3 a^4 / 8$. The angular integral is $4 pi$. So $A^2 (3 a^4 / 8) (4 pi) = 1 => A = sqrt(2 / (3 pi a^4))$.
#pagebreak()
#include "prerequisites/hydrogen_spherical.typ"

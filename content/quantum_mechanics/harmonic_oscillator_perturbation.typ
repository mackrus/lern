#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A system is described by the Hamiltonian of the one-dimensional harmonic oscillator $H_0 = planck omega (a^dagger a + 1/2)$. Suppose this system is perturbed and the Hamiltonian becomes $H = H_0 + H'$, where $H'$ is a small correction given by:
$ H' = gamma ((a^dagger)^6 + 2(a^dagger)^3 a^3 + a^6) $
+ Find the first order correction to the energy levels.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ E_n^((1)) = 2 gamma n (n - 1)(n - 2) $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ E_n^((1)) = gamma n^3 $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ E_n^((1)) = 0 $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ E_n^((1)) = 2 gamma (n+1)^3 $
#pagebreak()
#include "prerequisites/harmonic_perturbation.typ"

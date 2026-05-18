#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator with $H_0 = planck omega (a^dagger a + 1/2)$ is perturbed by $H' = gamma ((a^dagger)^6 + 2(a^dagger)^3 a^3 + a^6)$. Find the first order correction to the energy level $E_n$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 gamma n(n-1)(n-2)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
0
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$gamma n^3$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 gamma (n+1)^3$
#pagebreak()
#include "../explanations/hop_01.typ"
#pagebreak()
#include "../prerequisites/harmonic_perturbation.typ"

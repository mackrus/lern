#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator with $H_0 = planck omega (a^dagger a + 1/2)$ is perturbed by $H' = gamma ((a^dagger)^6 + 2(a^dagger)^3 a^3 + a^6)$. The second-order correction $E_n^((2))$ involves terms proportional to $gamma^2 / (planck omega)$. What is the denominator for the term involving the state $bar.v n+6 chevron.r$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$-6 planck omega$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$6 planck omega$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$planck omega$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
0
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The denominator is $E_n^((0)) - E_(n+6)^((0)) = (n+1/2)planck omega - (n+6+1/2)planck omega = -6 planck omega$.
#pagebreak()
#include "../prerequisites/harmonic_perturbation.typ"

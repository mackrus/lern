#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator with $H_0 = planck omega (a^dagger a + 1/2)$ is perturbed by $H' = gamma ((a^dagger)^6 + 2(a^dagger)^3 a^3 + a^6)$. Which states $bar.v m chevron.r$ couple to $bar.v n chevron.r$ to produce a non-zero contribution to the second-order energy correction $E_n^((2))$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+6 chevron.r$ and $bar.v n-6 chevron.r$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+3 chevron.r$ and $bar.v n-3 chevron.r$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$bar.v n+6 chevron.r$, $bar.v n chevron.r$, and $bar.v n-6 chevron.r$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
None
#expl_page(include "../explanations/hop_02.typ")
#prereq_page([
#include "../prerequisites/core/adv_expectation_values_of_products.typ"
#include "../prerequisites/core/prac_plancks_radiation_law.typ"
#include "../prerequisites/core/prac_infinite_well_spectrum.typ"
])

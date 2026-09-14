#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A particle in an infinite square well of width $a$ is in state $psi(x,t) = i/2 psi_1 e^(-i E_1 t / planck) - 1/2 psi_2 e^(-i E_2 t / planck) + 1/sqrt(2) psi_3 e^(-i E_3 t / planck)$. Find the expectation value of the energy $chevron.l E chevron.r$ in terms of the ground state energy $E_1$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$23/4 E_1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$14/3 E_1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$3 E_1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$5 E_1$
#expl_page(include "../explanations/swe_01.typ")

#formulae_page(include "../formulae/potential_wells_wavefunctions_core.typ")
#steps_page(include "../solution_steps/swe_01.typ")
#prereq_page([
#include "../prerequisites/core/adv_expectation_values_of_products.typ"
#include "../prerequisites/core/prac_stationary_time-dependence.typ"
#include "../prerequisites/core/prac_infinite_well_spectrum.typ"
])

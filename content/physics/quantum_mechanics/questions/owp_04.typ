#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator of mass $m$ and frequency $omega$ is described by ladder operators $a, a^dagger$. Compute the probability to measure energy $< 2 planck omega$ for the state $Psi prop (a^dagger + 2i a) a^dagger Psi_0$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2/3$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/3$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$
#expl_page(include "../explanations/owp_04.typ")
#formulae_page(include "../formulae/potential_wells_wavefunctions_core.typ")
#steps_page(include "../solution_steps/owp_04.typ")
#prereq_page([
#include "../prerequisites/core/hp_ladder_operator_orthogonality.typ"
])

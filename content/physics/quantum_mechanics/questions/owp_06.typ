#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
For an energy eigenstate $bar.v n chevron.r$ of the harmonic oscillator, what is the value of $sigma_x sigma_p$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(n+1/2) planck$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(n+1) planck / 2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$planck / 2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$n planck$
#expl_page(include "../explanations/owp_06.typ")

#formulae_page(include "../formulae/potential_wells_wavefunctions_core.typ")
#steps_page(include "../solution_steps/owp_06.typ")
#prereq_page(include "../prerequisites/core/ow_eigenstate_uncertainty.typ")

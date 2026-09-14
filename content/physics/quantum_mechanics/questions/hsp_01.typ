#import "../../../template.typ": *
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
#expl_page(include "../explanations/hsp_01.typ")

#formulae_page(include "../formulae/hydrogen_atom_core.typ")
#steps_page(include "../solution_steps/hsp_01.typ")
#prereq_page(include "../prerequisites/core/adv_spectrum_normalization.typ")

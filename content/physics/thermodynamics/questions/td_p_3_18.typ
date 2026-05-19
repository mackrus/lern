#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

For a reversible adiabatic expansion of an ideal gas with a constant adiabatic index $gamma$, which of the following sets of relations consistently describes the property constants across states?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$T V^(gamma - 1) = C_1$ and $T / P^(1 - 1/gamma) = C_2$
#pagebreak()
$T V^gamma = C_1$ and $T / P^gamma = C_2$
#pagebreak()
$T V^(gamma - 1) = C_1$ and $T P^(1 - 1/gamma) = C_2$
#pagebreak()
$T^gamma V = C_1$ and $T P^(gamma - 1) = C_2$

#expl_page(include "../explanations/td_p_3_18.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
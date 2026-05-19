#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

A gas characterized by an adiabatic exponent $gamma$ is compressed adiabatically from an initial state $(P_i, V_i)$ to a final state $(P_f, V_f)$. Which expression describes the work $W$ performed *on* the gas?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$W = (P_i V_i) / (gamma - 1) [ (V_i / V_f)^(gamma - 1) - 1 ]$
#pagebreak()
$W = (P_i V_i) / (gamma - 1) [ 1 - (V_i / V_f)^(gamma - 1) ]$
#pagebreak()
$W = (P_f V_f) / (gamma - 1) [ (V_f / V_i)^(gamma) - 1 ]$
#pagebreak()
$W = (P_i V_i) / (gamma + 1) [ (V_i / V_f)^(gamma - 1) - 1 ]$

#expl_page(include "../explanations/td_p_3_19.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
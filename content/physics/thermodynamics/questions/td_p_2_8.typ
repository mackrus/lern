#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

During a reversible adiabatic expansion of an ideal gas, the pressure and volume satisfy the condition $P V^gamma = c$. Which of the following expressions correctly defines the boundary work done *on* the system ($W_12$) during an expansion from $(P_1, V_1)$ to $(P_2, V_2)$?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$W_12 = - (P_1 V_1 - P_2 V_2) / (gamma - 1)$
#pagebreak()
$W_12 = (P_1 V_1 - P_2 V_2) / (gamma - 1)$
#pagebreak()
$W_12 = - (P_2 V_2 - P_1 V_1) / (gamma + 1)$
#pagebreak()
$W_12 = (P_1 V_1 + P_2 V_2) / (gamma - 1)$

#expl_page(include "../explanations/td_p_2_8.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
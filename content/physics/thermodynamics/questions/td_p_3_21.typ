#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

A thick-walled insulating chamber holds $n_1$ moles of helium gas at high pressure $P_1$ and temperature $T_1$. The gas leaks out slowly to the surrounding atmosphere (at pressure $P_0$) via a small control valve. What is the expression for the final number of moles ($n_2$) remaining inside the chamber?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$n_2 = n_1 (P_0 / P_1)^(1/gamma)$
#pagebreak()
$n_2 = n_1 (P_0 / P_1)^gamma$
#pagebreak()
$n_2 = n_1 (P_1 / P_0)^(1/gamma)$
#pagebreak()
$n_2 = n_1 (P_0 / P_1)^(1 - 1/gamma)$

#expl_page(include "../explanations/td_p_3_21.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

An ideal gas features a temperature-dependent molar heat capacity defined by $c_v = A + B T$. Which of the following expressions evaluates the change in entropy per mole ($Delta S$) when moving from an initial state $(V_1, T_1)$ to a final state $(V_2, T_2)$?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$Delta S = A ln(T_2 / T_1) + B(T_2 - T_1) + R ln(V_2 / V_1)$
#pagebreak()
$Delta S = A ln(T_2 / T_1) + 1/2 B(T_2^2 - T_1^2) + R ln(V_2 / V_1)$
#pagebreak()
$Delta S = (A + B) ln(T_2 / T_1) + R ln(V_2 / V_1)$
#pagebreak()
$Delta S = A ln(T_2 / T_1) + B(T_2 - T_1) - R ln(V_2 / V_1)$

#expl_page(include "../explanations/td_p_5_8.typ")
#prereq_page(include "../prerequisites/entropy_second_law.typ")
#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

An ideal gas undergoes a reversible thermodynamic cycle consisting of:
1. An isobaric expansion from $(P_1, V_1)$ to $(P_1, V_2)$
2. An isochoric pressure reduction to $(P_2, V_2)$
3. An isobaric compression to $(P_2, V_1)$
4. An isochoric pressure increase back to $(P_1, V_1)$

If $P_1 = 3.0 " atm"$, $P_2 = 1.0 " atm"$, $V_1 = 1.0 " L"$, and $V_2 = 2.0 " L"$, what is the total work done *on* the gas after traversing this cycle 100 times?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$-20.3 " kJ"$
#pagebreak()
$+20.3 " kJ"$
#pagebreak()
$-2.03 " kJ"$
#pagebreak()
$0 " kJ"$

#expl_page(include "../explanations/td_p_2_2.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

Two equal quantities of water of mass $m$ at initial temperatures $T_1$ and $T_2$ are mixed together inside an adiabatic container under constant pressure. Which equation correctly describes the total entropy change of the universe ($Delta S$)?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$Delta S = 2 m c_p ln( (T_1 + T_2) / (2 sqrt(T_1 T_2)) )$
#pagebreak()
$Delta S = m c_p ln( (T_1 + T_2) / (sqrt(T_1 T_2)) )$
#pagebreak()
$Delta S = 2 m c_p ln( (T_1 - T_2) / (2 sqrt(T_1 T_2)) )$
#pagebreak()
$Delta S = 0$

#expl_page(include "../explanations/td_p_5_11.typ")
#prereq_page(include "../prerequisites/entropy_second_law.typ")
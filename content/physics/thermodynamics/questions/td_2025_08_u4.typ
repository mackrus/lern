#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)


Two equal amounts ($n$) of the same liquid at $T_1$ and $T_2$ are mixed in an adiabatic system. Show that the entropy change is $Delta S = 2 n c ln( (T_1 + T_2) / (2 sqrt(T_1 * T_2)) )$.

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Equilibrium temperature $T_f = (T_1 + T_2) / 2$
#pagebreak()
Equilibrium temperature $T_f = sqrt(T_1 * T_2)$
#pagebreak()
Entropy change is zero
#pagebreak()
Entropy change is negative
#expl_page(include "../explanations/td_2025_08_u4.typ")
#prereq_page(include "../prerequisites/entropy_second_law.typ")

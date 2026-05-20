#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)


Use one of Maxwell's relations to calculate $((partial S) / (partial V))_T$ for a van der Waals gas:
$(P + a n^2 / V^2)(V - n b) = n R T$.
Compare with an ideal gas.

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$((partial S) / (partial V))_T = (n R) / (V - n b)$
#pagebreak()
$((partial S) / (partial V))_T = (n R) / V$
#pagebreak()
$((partial S) / (partial V))_T = (n R) / (V + n b)$
#pagebreak()
$((partial S) / (partial V))_T = 0$
#expl_page(include "../explanations/td_2025_06_u5.typ")
#prereq_page(include "../prerequisites/thermodynamic_potentials.typ")

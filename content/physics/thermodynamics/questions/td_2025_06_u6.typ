#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)


For a system, the Helmholtz free energy is $F(T, V) = -alpha T ln(V) + beta V$. Use Maxwell's relations to calculate the dependence of entropy on volume at constant temperature. Compare with direct calculation.

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$((partial S) / (partial V))_T = alpha / V$
#pagebreak()
$((partial S) / (partial V))_T = (alpha T) / V$
#pagebreak()
$((partial S) / (partial V))_T = beta$
#pagebreak()
$((partial S) / (partial V))_T = -alpha / V$
#expl_page(include "../explanations/td_2025_06_u6.typ")
#prereq_page(include "../prerequisites/thermodynamic_potentials.typ")

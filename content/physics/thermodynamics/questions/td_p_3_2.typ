#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

Water inside a rigid cylindrical insulated tank is set into rotation and left to come to rest under the action of viscous forces. Regarding the tank and the water as the closed system, how do work ($W$), heat ($Q$), and internal energy ($Delta U$) change as the water slows to a stop?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$W = 0$, $Q = 0$, and internal energy $U$ increases.
#pagebreak()
$W < 0$, $Q = 0$, and internal energy $U$ decreases.
#pagebreak()
$W = 0$, $Q < 0$, and internal energy $U$ decreases.
#pagebreak()
$W = 0$, $Q = 0$, and internal energy $U$ stays perfectly constant.

#expl_page(include "../explanations/td_p_3_2.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
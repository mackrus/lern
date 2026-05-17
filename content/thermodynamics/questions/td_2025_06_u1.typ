#import "../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)


Assume one mole of a monatomic ideal gas at $T_1 = 273$ K and $P_1 = 1.013 times 10^5$ Pa. 
The cyclic process is:
1. $(1) arrow (2)$: Isobaric expansion to $V_2 = 2 V_1$.
2. $(2) arrow (3)$: Isothermal compression to $P_3 = 2 P_2$.
3. $(3) arrow (1)$: Isochoric process back to the initial state.

Calculate $d U$, $d H$, $Q$, and $W$ for each step.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Isobaric work is negative, isothermal work is positive
#pagebreak()
Isobaric work is positive, isothermal work is negative
#pagebreak()
Net work is zero for the cycle
#pagebreak()
Internal energy change is non-zero for the cycle
#pagebreak()
#include "../explanations/td_2025_06_u1.typ"
#pagebreak()
#include "../prerequisites/ideal_gas_states.typ"

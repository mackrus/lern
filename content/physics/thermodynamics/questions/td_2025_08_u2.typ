#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)


Consider a Carnot cycle with $n$ moles of an ideal gas:
1. $(1) arrow (2)$: Isothermal expansion.
2. $(2) arrow (3)$: Adiabatic expansion.
3. $(3) arrow (4)$: Isothermal compression.
4. $(4) arrow (1)$: Adiabatic compression.

Express $Delta U, Q, W$ for each process. Indicate if work is performed on or by the gas.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Isothermal steps have $Delta U = 0$
#pagebreak()
Adiabatic steps have $Delta U = 0$
#pagebreak()
Isothermal steps have $Q = 0$
#pagebreak()
All steps have $Delta U = 0$
#expl_page(include "../explanations/td_2025_08_u2.typ")
#prereq_page(include "../prerequisites/heat_engines.typ")

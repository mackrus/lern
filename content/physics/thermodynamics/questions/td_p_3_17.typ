#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

On a standard pressure-volume ($P$-$V$) diagram, how does the slope of a reversible adiabatic curve compare to the slope of an isothermal curve passing through the exact same coordinate point?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
The adiabat is steeper by a factor of $gamma$.
#pagebreak()
The isotherm is steeper by a factor of $gamma$.
#pagebreak()
The curves have identical slopes.
#pagebreak()
The adiabat is steeper by a factor of $gamma - 1$.

#expl_page(include "../explanations/td_p_3_17.typ")
#prereq_page(include "../prerequisites/ideal_gas_states.typ")
#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

The length of the mercury column in a mercury-in-glass thermometer is 5.0 cm when the bulb is immersed in water at its triple point ($T_"TP" = 273.16 " K"$). 

If the length of the column can be measured within an uncertainty of only 0.01 cm, can this thermometer be used to safely distinguish between the ice point ($273.15 " K"$) and the triple point of water?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
No, because the required resolution ($0.00018 " cm"$) is much smaller than the thermometer's measurement uncertainty ($0.01 " cm"$).
#pagebreak()
Yes, because the required resolution ($0.02 " cm"$) is larger than the thermometer's measurement uncertainty.
#pagebreak()
No, because a mercury thermometer scale cannot be modeled linearly for small temperature transitions.
#pagebreak()
Yes, because the length changes by exactly $0.10 " cm"$ per $0.01 " K"$.

#expl_page(include "../explanations/td_p_1_3.typ")
#prereq_page(include "../prerequisites/thermometry.typ")
#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

You have a hot cup of coffee in an open, well-insulated cylindrical thermos mug and a separate container of cold milk. You plan to drink the mixture after a short delay. To ensure the coffee is as hot as possible when you drink it, should you pour the milk in immediately or wait right before drinking it?

#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Pour the milk in immediately to lower the temperature early and minimize heat loss during the waiting period.
#pagebreak()
Wait and add the milk at the end to keep the thermal gradient high and speed up initial cooling.
#pagebreak()
It does not matter; the total energy lost by the fluid volume over time will be identical.
#pagebreak()
Pour the milk in slowly over the entire period to balance the convective heat transfer coefficient.

#expl_page(include "../explanations/td_p_thermal_radiation_ii_coffee_and_milk.typ")
#prereq_page(include "../prerequisites/heat_transfer_modes.typ")
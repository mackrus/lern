#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

Why is carbon dioxide radiative forcing parameterized as $Delta Q_"CO2" = 5.35 ln(r / r_0)$ rather than linearly?
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Because the core of the primary $15 mu"m"$ $CO_2$ absorption band is already saturated
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Because $CO_2$ dissolves logarithmically into ocean surface water
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Because photochemical breakdown of $CO_2$ accelerates exponentially with concentration
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
Because solar irradiance decreases logarithmically through the atmosphere
#expl_page(include "../explanations/climate_05.typ")
#formulae_page(include "../formulae/climate_core.typ")
#steps_page(include "../solution_steps/climate_05.typ")

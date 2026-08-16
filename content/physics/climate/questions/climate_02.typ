#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

In an idealized 1-layer isothermal atmosphere transparent to solar shortwave radiation but absorbing 100% of terrestrial longwave radiation, what is the surface temperature $T_s$?
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$T_s = 2^(1/4) T_e approx 303 "K"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$T_s = 2^(1/2) T_e approx 360 "K"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$T_s = (1 + epsilon) T_e approx 438 "K"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$T_s = T_e approx 255 "K"$
#expl_page(include "../explanations/climate_02.typ")
#formulae_page(include "../formulae/climate_core.typ")
#steps_page(include "../solution_steps/climate_02.typ")

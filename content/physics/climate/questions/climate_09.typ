#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

Using the barometric formula $p(z) = p_0 e^(- (g Delta z) / (R_d T))$ with $g = 9.81 "m/s"^2$, $R_d = 287 "J/(kg K)"$, layer temperature $T = 5 degree"C"$ ($278.15 "K"$), and $p_0 = 1000 "hPa"$, what is the pressure at the top of Kebnekaise ($Delta z = 2097 "m"$)?
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$approx 773 "hPa"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$approx 500 "hPa"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$approx 920 "hPa"$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$approx 650 "hPa"$
#expl_page(include "../explanations/climate_09.typ")
#formulae_page(include "../formulae/climate_core.typ")
#steps_page(include "../solution_steps/climate_09.typ")

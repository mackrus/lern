#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

What is the 100-year Global Warming Potential ($"GWP"_100$) of Methane ($CH_4$) and Nitrous Oxide ($N_2O$) relative to $CO_2$?
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$CH_4: 1$; $N_2O: 1$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$CH_4: 27-28$; $N_2O: 273$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$CH_4: 273$; $N_2O: 28$
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
$CH_4: 17500$; $N_2O: 23500$
#expl_page(include "../explanations/climate_25.typ")
#formulae_page(include "../formulae/climate_core.typ")
#steps_page(include "../solution_steps/climate_25.typ")

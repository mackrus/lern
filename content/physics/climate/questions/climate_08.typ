#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)

What distinguishes General Circulation Models (GCMs) from 0-D/1-D Energy Balance Models (EBMs)?
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
EBMs solve 3D Navier-Stokes equations; GCMs assume an isothermal 1D column
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
GCMs solve 3D primitive equations for momentum, mass continuity, energy, and moisture on a spatial grid, whereas EBMs parameterize energy fluxes in 0D/1D
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
EBMs have dynamic chemistry while GCMs only simulate ice sheets
#pagebreak()
#set page(width: a_width, height: auto, margin: a_margin)
#set text(size: a_size)
GCMs require less computing power and run faster than 0-D EBMs
#expl_page(include "../explanations/climate_08.typ")
#formulae_page(include "../formulae/climate_core.typ")
#steps_page(include "../solution_steps/climate_08.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Quantum teleportation allows transferring the state of a quantum particle faster than the speed of light, but measurement cannot be done fast enough in principle, preserving causality.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#expl_page(include "../explanations/acp_02.typ")

#steps_page(include "../solution_steps/acp_02.typ")
#prereq_page(include "../prerequisites/core/adv_quantum_teleportation.typ")

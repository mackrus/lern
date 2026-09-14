#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A particle has orbital angular momentum $l=1$ and spin $s=1/2$. What are the possible values for the total angular momentum quantum number $j$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/2, 3/2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0, 1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$3/2, 5/2$
#expl_page(include "../explanations/sam_06.typ")

#formulae_page(include "../formulae/spin_angular_momentum_core.typ")
#steps_page(include "../solution_steps/sam_06.typ")
#prereq_page(include "../prerequisites/core/sam_addition_of_angular_momentum.typ")

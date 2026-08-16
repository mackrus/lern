#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Bell's inequality was experimentally confirmed to hold, which was a major argument against the existence of hidden variables.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Bell's inequality is *violated* by quantum mechanics.
#steps_page(include "../solution_steps/acp_03.typ")
#prereq_page([
#include "../prerequisites/core/adv_bell's_inequality.typ"
])

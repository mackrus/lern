#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A beam of spin-1/2 particles is passed through a sequence of Stern-Gerlach (SG) filters. Evaluate the fraction of particles passing through three consecutive filters oriented along $z, x, z$ axes.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/4$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/2$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1/8$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$
#expl_page(include "../explanations/sam_02.typ")
#prereq_page([
#include "../prerequisites/core/sam_spin-1_2_operators.typ"
#include "../prerequisites/core/sam_measurement_probabilities.typ"
])

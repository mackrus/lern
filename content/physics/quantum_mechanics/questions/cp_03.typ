#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
$psi_A(0) = (1/2 + sqrt(2)i)lambda^(-3/2)$, $psi_B(0) = e^(1/2 + sqrt(2)i)lambda^(-3/2)$. It is more probable to find B than A at the origin.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#expl_page(include "../explanations/cp_03.typ")
#prereq_page([
#include "../prerequisites/core/prac_born_rule.typ"
])

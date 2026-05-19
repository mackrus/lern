#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Compute the commutator $[a^dagger a, a]$ using only the fundamental relation $[a, a^dagger] = 1$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$a$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$-a$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$
#expl_page(include "../explanations/acp_01.typ")
#prereq_page([
#include "../prerequisites/core/adv_operator_algebra.typ"
#include "../prerequisites/core/adv_expectation_values_of_products.typ"
])

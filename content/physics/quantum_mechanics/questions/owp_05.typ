#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Prove the Heisenberg Uncertainty Principle $ sigma_x sigma_p >= planck/2 $ from the commutator $[x, p] = i planck$. Which operator identity is the starting point for this proof?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Cauchy-Schwarz inequality
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Triangle inequality
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Euler's identity
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Taylor expansion
#expl_page(include "../explanations/owp_05.typ")
#prereq_page([
#include "../prerequisites/core/adv_operator_algebra.typ"
#include "../prerequisites/core/prac_heisenberg_uncertainty_principle.typ"
#include "../prerequisites/core/prac_plancks_radiation_law.typ"
])

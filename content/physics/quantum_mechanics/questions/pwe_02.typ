#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a particle in a symmetric potential well: $V(x)=0$ for $|x| <= a$, $V(x)=V_0$ for $a < |x| < b$, and $V(x)=infinity$ for $|x| > b$. Which transcendental equation determines the energies of the *odd* wave functions?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k cot(k a) = - kappa coth(kappa(b-a))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k tan(k a) = kappa tanh(kappa(b-a))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k cot(k a) = kappa tanh(kappa b)$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
None
#expl_page(include "../explanations/pwe_02.typ")
#prereq_page([
#include "../prerequisites/core/pw_odd_state_transcendental_equation.typ"
])

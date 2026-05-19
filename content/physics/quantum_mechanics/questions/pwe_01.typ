#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a particle in a symmetric potential well: $V(x)=0$ for $|x| <= a$, $V(x)=V_0$ for $a < |x| < b$, and $V(x)=infinity$ for $|x| > b$. For $0 < E < V_0$, which transcendental equation determines the energies of the *even* wave functions?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k tan(k a) = kappa coth(kappa(b-a))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k tan(k a) = - kappa tanh(kappa(b-a))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k cot(k a) = kappa tanh(kappa(b-a))$
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$k tan(k a) = kappa tanh(kappa b)$
#expl_page(include "../explanations/pwe_01.typ")
#prereq_page(include "../prerequisites/potential_wells.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all analytic functions $f(z) = u(x, y) + i v(x, y)$ whose real part satisfies $(partial u) / (partial x) = -u$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a e^(-z) + i b, quad a in CC, b in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = e^(-z) + c, quad c in CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a e^z + i b, quad a in RR, b in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a e^(-x) + i b, quad a, b in RR$

#expl_page(include "../explanations/ca_44.typ")
#formulae_page(include "../formulae/ca_44.typ")
#steps_page(include "../solution_steps/ca_44.typ")
#prereq_page(include "../prerequisites/ca_44.typ")

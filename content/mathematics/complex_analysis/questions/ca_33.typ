#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For $z = x + i y eq.not 0$ with $theta = "arg"(z)$, determine the real part $"Re"(z^z)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x ln|z| - y "arg" z) cos(y ln|z| + x "arg" z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$|z|^x cos(y ln|z|)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(x ln|z| + y "arg" z) cos(y ln|z| - x "arg" z)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$e^(- y "arg" z) cos(x ln|z|)$

#expl_page(include "../explanations/ca_33.typ")
#formulae_page(include "../formulae/ca_33.typ")
#steps_page(include "../solution_steps/ca_33.typ")
#prereq_page(include "../prerequisites/ca_33.typ")

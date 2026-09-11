#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Calculate the first three non-vanishing coefficients $c_0, c_1, c_2$ of the Maclaurin expansion $sum_(n=0)^oo c_n z^n$ for the function $f(z) = e^(z / (1 - z))$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1, quad 1, quad 3/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1, quad 1, quad 1/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1, quad 2, quad 5/2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$1, quad 1, quad 2$

#expl_page(include "../explanations/ca_79.typ")
#formulae_page(include "../formulae/ca_79.typ")
#steps_page(include "../solution_steps/ca_79.typ")
#prereq_page(include "../prerequisites/ca_79.typ")

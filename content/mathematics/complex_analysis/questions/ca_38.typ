#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all harmonic conjugates $v(x, y)$ of the harmonic function $u(x, y) = x^2 - y^2 + 5$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$v(x, y) = 2 x y + C, quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$v(x, y) = x^2 + y^2 + C, quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$v(x, y) = -2 x y + C, quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$v(x, y) = 2 x^2 y + C, quad C in RR$

#expl_page(include "../explanations/ca_38.typ")
#formulae_page(include "../formulae/ca_38.typ")
#steps_page(include "../solution_steps/ca_38.typ")
#prereq_page(include "../prerequisites/ca_38.typ")

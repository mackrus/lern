#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all analytic functions $f(z) = u(x, y) + i v(x, y)$ satisfying $"Re"(f) + "Im"(f) = u + v = x y$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (1 - i) / 4 (z^2 + C), quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (1 + i) / 2 (z^2 + C), quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (1 - i) / 2 (z + C), quad C in RR$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = - i / 2 z^2 + C, quad C in RR$

#expl_page(include "../explanations/ca_39.typ")
#formulae_page(include "../formulae/ca_39.typ")
#steps_page(include "../solution_steps/ca_39.typ")
#prereq_page(include "../prerequisites/ca_39.typ")

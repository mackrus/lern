#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a conformal mapping which maps the region between $|z - 1| > 1$ and $|z| < 2$ onto the upper half plane.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = exp((2 pi i z) / (z - 2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = exp((pi z) / (z - 2))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (2 pi i z) / (z - 2)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = ((z - 2) / z)^2$

#expl_page(include "../explanations/ca_52.typ")
#formulae_page(include "../formulae/ca_52.typ")
#steps_page(include "../solution_steps/ca_52.typ")
#prereq_page(include "../prerequisites/ca_52.typ")

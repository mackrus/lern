#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a conformal mapping which maps the region between $|z + 3| < sqrt(10)$ and $|z - 2| < sqrt(5)$ onto the interior of the first quadrant.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (3 + 4 i) ((z - i) / (z + i))^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = ((z - i) / (z + i))^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (3 - 4 i) ((z + i) / (z - i))^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z - 1) / (z + 2)$

#expl_page(include "../explanations/ca_51.typ")
#formulae_page(include "../formulae/ca_51.typ")
#steps_page(include "../solution_steps/ca_51.typ")
#prereq_page(include "../prerequisites/ca_51.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Determine the unique function $f$ analytic in $|z| < 1$ that satisfies:
$ f(1 / k) = (k + k^2) / (1 + k^2), quad k = 2, 3, 4, dots $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z + 1) / (z^2 + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z^2 + z) / (z^2 + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1 / (z + 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (z + 1) / (z - 1)$

#expl_page(include "../explanations/ca_86.typ")
#formulae_page(include "../formulae/ca_86.typ")
#steps_page(include "../solution_steps/ca_86.typ")
#prereq_page(include "../prerequisites/ca_86.typ")

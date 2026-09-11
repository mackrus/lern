#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Classify the isolated singularities at $z = 0$ for the two functions $f_1(z) = (z - sin z) / z^3$ and $f_2(z) = z^2 sin(1 / z)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_1$ has a removable singularity; $f_2$ has an essential singularity

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_1$ has a pole of order 3; $f_2$ has a removable singularity

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Both functions have poles of order 2

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_1$ has a removable singularity; $f_2$ has a simple pole

#expl_page(include "../explanations/ca_90.typ")
#formulae_page(include "../formulae/ca_90.typ")
#steps_page(include "../solution_steps/ca_90.typ")
#prereq_page(include "../prerequisites/ca_90.typ")

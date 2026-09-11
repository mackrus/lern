#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

What function is represented by the power series $sum_(n=1)^oo n^2 z^n$ for $|z| < 1$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(z^2 + z) / (1 - z)^3$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z / (1 - z)^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 z^2) / (1 - z)^3$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$z / (1 - z)^3$

#expl_page(include "../explanations/ca_78.typ")
#formulae_page(include "../formulae/ca_78.typ")
#steps_page(include "../solution_steps/ca_78.typ")
#prereq_page(include "../prerequisites/ca_78.typ")

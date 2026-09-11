#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the integral:
$ integral_gamma d z / (z^2 + 1)^4 $
where $gamma$ represents the positively oriented rectangle with vertices at $2, 2 + 2i, -2 + 2i, -2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(5 pi) / 16$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$pi / 8$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(3 pi) / 16$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#expl_page(include "../explanations/ca_92.typ")
#formulae_page(include "../formulae/ca_92.typ")
#steps_page(include "../solution_steps/ca_92.typ")
#prereq_page(include "../prerequisites/ca_92.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Use the Residue Theorem to evaluate the Cauchy principal value integral:
$ "P.V." integral_(-oo)^oo x / ((x^2 + 1)(x^2 + 2x + 2)) thin d x $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ - pi / 5 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi / 5 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ - (2 pi) / 5 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $

#expl_page(include "../explanations/ca_20.typ")
#formulae_page(include "../formulae/ca_20.typ")
#steps_page(include "../solution_steps/ca_20.typ")
#prereq_page(include "../prerequisites/ca_20.typ")

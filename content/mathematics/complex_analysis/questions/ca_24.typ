#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Use the Residue Theorem and Jordan's Lemma to evaluate the integral for $a > 0$:
$ integral_(-oo)^oo (x sin(a x)) / (x^4 + 4) thin d x $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi / 2 e^(-a) sin a $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi e^(-a) cos a $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi / 2 e^(-a) cos a $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $

#expl_page(include "../explanations/ca_24.typ")
#formulae_page(include "../formulae/ca_24.typ")
#steps_page(include "../solution_steps/ca_24.typ")
#prereq_page(include "../prerequisites/ca_24.typ")

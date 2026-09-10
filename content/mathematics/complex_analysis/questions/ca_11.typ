#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $C$ denote the positively oriented circle $|z| = 3$. Evaluate the contour integral:
$ integral_C (e^(-z)) / (z - (pi i) / 2) thin d z $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2 pi $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -2 i $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2 pi i $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $

#expl_page(include "../explanations/ca_11.typ")
#formulae_page(include "../formulae/ca_11.typ")
#steps_page(include "../solution_steps/ca_11.typ")
#prereq_page(include "../prerequisites/ca_11.typ")

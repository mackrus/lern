#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Evaluate the double integral
$ integral.double_R (x + y)^2 e^(x - y) d A $
where $R$ is the square region bounded by the vertices $(1, 0)$, $(2, 1)$, $(1, 2)$, and $(0, 1)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 13/3 (e - e^(-1)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 26/3 (e - e^(-1)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 13/3 (e + e^(-1)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 13/6 (e - e^(-1)) $

#expl_page(include "../explanations/mvc_06.typ")
#formulae_page(include "../formulae/mvc_06.typ")
#steps_page(include "../solution_steps/mvc_06.typ")
#prereq_page(include "../prerequisites/mvc_06.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the multivariable limit if it exists:
$ lim_((x,y,z)->(0,0,0)) (x^2 y^2 + x^2 z + y z) / (x^2 + y^2 + z^2) $.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ text("does not exist") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1 / 2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1 $

#expl_page(include "../explanations/mvc_28.typ")
#formulae_page(include "../formulae/mvc_28.typ")
#steps_page(include "../solution_steps/mvc_28.typ")
#prereq_page(include "../prerequisites/mvc_28.typ")

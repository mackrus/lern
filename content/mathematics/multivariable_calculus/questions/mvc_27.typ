#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the multivariable limit if it exists:
$ lim_((x,y)->(0,0)) (y sin(x^2 + y^2)) / (x^2 + y^2) $.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ text("does not exist") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1 / 2 $

#expl_page(include "../explanations/mvc_27.typ")
#formulae_page(include "../formulae/mvc_27.typ")
#steps_page(include "../solution_steps/mvc_27.typ")
#prereq_page(include "../prerequisites/mvc_27.typ")

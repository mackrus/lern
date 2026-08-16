#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $T(x, y) = x^4 + 2 y^2 + 1$ describe the temperature at any point $(x, y)$ on $RR^2$. An insect travels along the trajectory $y = x^2 - 3$. At which points of the trajectory will it experience the lowest possible temperature?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (sqrt(2), -1) #h(0.5em) text("and") #h(0.5em) (-sqrt(2), -1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (0, -3) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (sqrt(3), 0) #h(0.5em) text("and") #h(0.5em) (-sqrt(3), 0) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (1, -2) #h(0.5em) text("and") #h(0.5em) (-1, -2) $

#expl_page(include "../explanations/mvc_20.typ")
#formulae_page(include "../formulae/mvc_20.typ")
#steps_page(include "../solution_steps/mvc_20.typ")
#prereq_page(include "../prerequisites/mvc_20.typ")

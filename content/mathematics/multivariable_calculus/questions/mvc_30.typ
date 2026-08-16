#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $Y_1$ be the surface $z = x^2 + y^2$ and $Y_2$ be the surface $z = -(x+1)^2 - y^2 + 1$. Let $gamma$ be the intersection curve of $Y_1$ and $Y_2$. Find the projection equations of $gamma$ onto the $x y$-plane and $x z$-plane.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (x + 1/2)^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -x text(" for ") -1 <= x <= 0 text(" on ") x z text("-plane") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -x text(" on ") x z text("-plane") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (x - 1/2)^2 + y^2 = 1/4 text(" on ") x y text("-plane, and ") z = x text(" for ") 0 <= x <= 1 text(" on ") x z text("-plane") $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (x + 1/2)^2 + 2y^2 = 1/4 text(" on ") x y text("-plane, and ") z = -2x text(" for ") -1 <= x <= 0 text(" on ") x z text("-plane") $

#expl_page(include "../explanations/mvc_30.typ")
#formulae_page(include "../formulae/mvc_30.typ")
#steps_page(include "../solution_steps/mvc_30.typ")
#prereq_page(include "../prerequisites/mvc_30.typ")

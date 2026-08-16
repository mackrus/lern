#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Evaluate the line integral $integral.cont_C bold(F) dot d bold(r)$, where $bold(F)(x, y, z) = (z^2 - y^2) bold(i) + (x^2 - z^2) bold(j) + (y^2 - x^2) bold(k)$ and $C$ is the boundary curve formed by the intersection of the unit cube $[0,1] times [0,1] times [0,1]$ with the plane $x + y + z = 3/2$, oriented counterclockwise when viewed from above.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 9/2 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 9/4 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 6 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 3/2 $

#expl_page(include "../explanations/mvc_08.typ")
#formulae_page(include "../formulae/mvc_08.typ")
#steps_page(include "../solution_steps/mvc_08.typ")
#prereq_page(include "../prerequisites/mvc_08.typ")

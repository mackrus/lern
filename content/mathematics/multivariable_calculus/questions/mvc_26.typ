#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $x in RR$ and matrix $A$ given by:
$ A = mat(x, x, x, x; 1, x, x, x; 2, 2, x, x; 0, 2, -1, x) $
Determine for which values of $x$ the matrix $A$ is invertible.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$text("All ") x text(" except ") x = -1, 0, 1, 2$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$text("All ") x text(" except ") x = 0, 1, 2$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$text("Only ") x = -1, 0, 1, 2$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$text("All ") x text(" except ") x = -1, 1, 2$

#expl_page(include "../explanations/mvc_26.typ")
#formulae_page(include "../formulae/mvc_26.typ")
#steps_page(include "../solution_steps/mvc_26.typ")
#prereq_page(include "../prerequisites/mvc_26.typ")

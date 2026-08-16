#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $T: RR^2 -> RR^2$ be a linear transformation with standard matrix:
$ [T] = mat(1/5, -2/5; -2/5, 4/5) $
Find the eigenvalues of $[T]$ and the equation of the line onto which $T$ projects.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$lambda = 0, 1 text(" and line ") 2x + y = 0$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$lambda = 1, 2 text(" and line ") x - 2y = 0$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$lambda = 0, 1 text(" and line ") x - 2y = 0$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$lambda = -1, 1 text(" and line ") 2x + y = 0$

#expl_page(include "../explanations/mvc_23.typ")
#formulae_page(include "../formulae/mvc_23.typ")
#steps_page(include "../solution_steps/mvc_23.typ")
#prereq_page(include "../prerequisites/mvc_23.typ")

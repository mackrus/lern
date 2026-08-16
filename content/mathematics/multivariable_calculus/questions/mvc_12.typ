#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $0 < x < 1$ be a real constant and matrix $A$ given by:
$ A = mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $
Compute the inverse matrix $A^{-1}$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(x, sqrt(1 - x^2), 0; sqrt(1 - x^2), -x, 0; 0, 0, -1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(-x, sqrt(1 - x^2), 0; sqrt(1 - x^2), x, 0; 0, 0, 1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(x, -sqrt(1 - x^2), 0; -sqrt(1 - x^2), -x, 0; 0, 0, -1) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ mat(-x, -sqrt(1 - x^2), 0; -sqrt(1 - x^2), x, 0; 0, 0, -1) $

#expl_page(include "../explanations/mvc_12.typ")
#formulae_page(include "../formulae/mvc_12.typ")
#steps_page(include "../solution_steps/mvc_12.typ")
#prereq_page(include "../prerequisites/mvc_12.typ")

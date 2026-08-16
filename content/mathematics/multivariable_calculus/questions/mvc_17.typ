#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Consider the curve in $RR^3$ defined by the system of equations:
$ x^2 + y^3 + z^4 = 3 $
$ x y + x z + y z = 3 $
To show that near the point $(1, 1, 1)$ we can parameterize this curve using $z$ as the parameter (i.e. $x$ and $y$ can be viewed as functions of $z$), compute the determinant of the Jacobian matrix with respect to the dependent variables $x$ and $y$ at $(1, 1, 1)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -4 $

#expl_page(include "../explanations/mvc_17.typ")
#formulae_page(include "../formulae/mvc_17.typ")
#steps_page(include "../solution_steps/mvc_17.typ")
#prereq_page(include "../prerequisites/mvc_17.typ")

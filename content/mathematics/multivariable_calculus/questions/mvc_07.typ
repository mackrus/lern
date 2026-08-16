#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Evaluate the line integral
$ integral.cont_C (y^3 - ln(x^2 + 1)) d x + (3 x y^2 + cos(y^2)) d y $
where $C$ is the positively oriented boundary of the semi-annular region $D$ situated between the circles $x^2 + y^2 = 1$ and $x^2 + y^2 = 4$ in the upper half-plane ($y \ge 0$).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 0 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 3 pi / 2 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 15/4 $

#expl_page(include "../explanations/mvc_07.typ")
#formulae_page(include "../formulae/mvc_07.typ")
#steps_page(include "../solution_steps/mvc_07.typ")
#prereq_page(include "../prerequisites/mvc_07.typ")

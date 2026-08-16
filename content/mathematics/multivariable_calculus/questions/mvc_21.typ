#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Use polar coordinates to evaluate the double integral
$ integral.double_D 1 / (x^2 + y^2)^(3/2) d x d y $
where $D$ is the region defined by $x >= 0$, $y >= 0$, $y <= 1$, $y >= x$, and $x^2 + y^2 >= 1$. (You may use that $integral 1 / sin^2(theta) d theta = -cos(theta)/sin(theta)$).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi/4 - sqrt(2)/2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi/2 - sqrt(2)/2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi/4 - 1/2 $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ pi/4 + sqrt(2)/2 $

#expl_page(include "../explanations/mvc_21.typ")
#formulae_page(include "../formulae/mvc_21.typ")
#steps_page(include "../solution_steps/mvc_21.typ")
#prereq_page(include "../prerequisites/mvc_21.typ")

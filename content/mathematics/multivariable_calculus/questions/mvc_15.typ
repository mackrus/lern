#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Determine if the partial derivative $f_x(x, y)$ is continuous at $(0, 0)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_x(x, y)$ is not continuous at $(0, 0)$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_x(x, y)$ is continuous at $(0, 0)$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_x(x, y)$ is not defined at $(0, 0)$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f_x(x, y)$ is continuous everywhere except along the line $y = x$

#expl_page(include "../explanations/mvc_15.typ")
#formulae_page(include "../formulae/mvc_15.typ")
#steps_page(include "../solution_steps/mvc_15.typ")
#prereq_page(include "../prerequisites/mvc_15.typ")

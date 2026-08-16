#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y) = (x-y)^3 / (x^2 + y^2)$ if $(x, y) != (0, 0)$, and $f(0, 0) = 0$. Determine where $f(x, y)$ is continuous on $RR^2$ and the values of the partial derivatives $f_x(0, 0)$ and $f_y(0, 0)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ is continuous everywhere on $RR^2$, and $f_x(0, 0) = 1, f_y(0, 0) = -1$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ is continuous everywhere except at $(0, 0)$, and $f_x(0, 0) = 1, f_y(0, 0) = -1$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ is continuous everywhere on $RR^2$, and $f_x(0, 0) = 0, f_y(0, 0) = 0$#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ is continuous everywhere except at $(0, 0)$, and the partial derivatives at $(0, 0)$ do not exist

#expl_page(include "../explanations/mvc_14.typ")
#formulae_page(include "../formulae/mvc_14.typ")
#steps_page(include "../solution_steps/mvc_14.typ")
#prereq_page(include "../prerequisites/mvc_14.typ")

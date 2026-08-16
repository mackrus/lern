#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y, z) = x^2 y + y z^2 + z x^2$.

Determine the equation of the tangent plane to the level surface $f(x, y, z) = 1$ at the point $P(1, -1, 2)$.
*(Hint: The gradient at $P$ is $nabla f(P) = chevron.l 2, 5, -3 chevron.r$)*

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2x + 5y - 3z = -9 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2x - 5y + 3z = 13 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2x + 5y - 3z = 9 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ x - y + 2z = 6 $

#expl_page(include "../explanations/mvc_03.typ")
#formulae_page(include "../formulae/mvc_03.typ")
#steps_page(include "../solution_steps/mvc_03.typ")
#prereq_page(include "../prerequisites/mvc_03.typ")

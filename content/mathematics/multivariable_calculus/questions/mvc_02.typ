#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(x, y, z) = x^2 y + y z^2 + z x^2$.

Find the directional derivative of $f$ at the point $P(1, -1, 2)$ in the direction of the vector $bold(v) = 2 bold(i) - bold(j) + 2 bold(k)$.
*(Hint: The gradient at $P$ is $nabla f(P) = chevron.l 2, 5, -3 chevron.r$)*

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -7/3 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -1/3 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -7 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -5/3 $

#expl_page(include "../explanations/mvc_02.typ")
#formulae_page(include "../formulae/mvc_02.typ")
#steps_page(include "../solution_steps/mvc_02.typ")
#prereq_page(include "../prerequisites/mvc_02.typ")

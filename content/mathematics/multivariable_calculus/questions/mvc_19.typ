#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f = f(s, t)$. Solve the partial differential equation
$ s (partial f) / (partial s) - t (partial f) / (partial t) = 2 s^4 - 2 t^4 $
using the change of variables $x = s^2 - t^2$, $y = 2 s t$. (Here $g$ is an arbitrary differentiable function).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ f(s, t) = 1/2 (s^2 - t^2)^2 + g(2 s t) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ f(s, t) = (s^2 - t^2)^2 + g(2 s t) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ f(s, t) = 1/2 (s^2 - t^2)^2 + g(s^2 + t^2) $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ f(s, t) = 1/2 (s^2 + t^2)^2 + g(2 s t) $

#expl_page(include "../explanations/mvc_19.typ")
#formulae_page(include "../formulae/mvc_19.typ")
#steps_page(include "../solution_steps/mvc_19.typ")
#prereq_page(include "../prerequisites/mvc_19.typ")

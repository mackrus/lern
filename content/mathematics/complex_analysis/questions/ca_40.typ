#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

If $u$ is harmonic and $v$ is a harmonic conjugate of $u$, evaluate:
$ (partial) / (partial x) [u (partial u) / (partial x) - v (partial v) / (partial x)] - (partial) / (partial y) [v (partial u) / (partial x) + u (partial v) / (partial x)] $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$|f'(z)|^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 ((partial u) / (partial x))^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$- 4 u v$

#expl_page(include "../explanations/ca_40.typ")
#formulae_page(include "../formulae/ca_40.typ")
#steps_page(include "../solution_steps/ca_40.typ")
#prereq_page(include "../prerequisites/ca_40.typ")

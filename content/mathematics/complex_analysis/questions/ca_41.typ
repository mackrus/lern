#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f = u + i v$ be analytic and non-constant. Why can $u^2 + v^2 = |f|^2$ never be the real part of an analytic function?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $Delta(|f|^2) = 4 |f'(z)|^2 > 0$, so $|f|^2$ cannot be harmonic

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $|f|^2 >= 0$ everywhere, and real parts of analytic functions must change sign

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $|f|^2$ is not differentiable with respect to $z$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because the Cauchy-Riemann equations require $u^2 - v^2 = 0$

#expl_page(include "../explanations/ca_41.typ")
#formulae_page(include "../formulae/ca_41.typ")
#steps_page(include "../solution_steps/ca_41.typ")
#prereq_page(include "../prerequisites/ca_41.typ")

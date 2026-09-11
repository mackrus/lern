#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f_n(x) = (n x) / (n x + 1)$ on $[0, 1]$. Is it true that $lim_(n -> oo) integral_0^1 f_n(x) thin d x = integral_0^1 lim_(n -> oo) f_n(x) thin d x$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, both evaluate to $1$, even though convergence is not uniform on $[0, 1]$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, because {f_n} does not converge uniformly on $[0, 1]$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, because {f_n} converges uniformly on $[0, 1]$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, the integral limit is $0$ while the pointwise limit integral is $1$

#expl_page(include "../explanations/ca_73.typ")
#formulae_page(include "../formulae/ca_73.typ")
#steps_page(include "../solution_steps/ca_73.typ")
#prereq_page(include "../prerequisites/ca_73.typ")

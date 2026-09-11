#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Why does the series $sum_(n=1)^oo e^(-n^2 z)$ represent a function analytic in the right half-plane ${"Re"(z) > 0}$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Each term is entire and the series converges locally uniformly on compact subsets of ${"Re"(z) > 0}$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because $e^(-n^2 z)$ is bounded on all of $CC$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because the radius of convergence of the power series is infinite

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Because the Cauchy-Goursat theorem applies to each term individually

#expl_page(include "../explanations/ca_75.typ")
#formulae_page(include "../formulae/ca_75.typ")
#steps_page(include "../solution_steps/ca_75.typ")
#prereq_page(include "../prerequisites/ca_75.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Can there exist a function $f$, analytic in the unit disk $|z| < 1$, such that $f(1 / (2k)) = 1 / (2k)$ and $f(1 / (2k + 1)) = 1 / (2k)$ for all $k = 1, 2, 3, dots$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, it is impossible by the Uniqueness Principle

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, such a function is given by $f(z) = z$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, by the Weierstrass Factorization Theorem

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, because $f$ would have an essential singularity at the origin

#expl_page(include "../explanations/ca_85.typ")
#formulae_page(include "../formulae/ca_85.typ")
#steps_page(include "../solution_steps/ca_85.typ")
#prereq_page(include "../prerequisites/ca_85.typ")

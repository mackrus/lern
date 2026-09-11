#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Suppose that $f$ is analytic in $|z| <= R$ and satisfies $|f(z)| <= M$. Which expression gives an optimal upper bound for $|f^((n))(z)|$ on the inner disk $|z| <= r < R$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(n! M R) / (R - r)^(n+1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(n! M) / (R - r)^n$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(M R^n) / (R - r)^(n+1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(n! M) / R^n$

#expl_page(include "../explanations/ca_68.typ")
#formulae_page(include "../formulae/ca_68.typ")
#steps_page(include "../solution_steps/ca_68.typ")
#prereq_page(include "../prerequisites/ca_68.typ")

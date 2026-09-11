#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For which complex numbers $z in CC$ does the sequence $f_n(z) = 1 / (1 + z + z^2 + dots + z^n)$ converge as $n -> oo$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
For all $|z| eq.not 1$ and for $z = 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Only for $|z| < 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
For $|z| <= 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
For all $z in CC without {-1}$

#expl_page(include "../explanations/ca_71.typ")
#formulae_page(include "../formulae/ca_71.typ")
#steps_page(include "../solution_steps/ca_71.typ")
#prereq_page(include "../prerequisites/ca_71.typ")

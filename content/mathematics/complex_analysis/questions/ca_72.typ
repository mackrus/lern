#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Consider the sequence $f_n(z) = e^(-n z)$ for $n in ZZ^+$. Is $f_n(z)$ uniformly convergent to $0$ on the open right half plane ${"Re"(z) > 0}$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, because $sup_("Re"(z) > 0) |e^(-n z)| = 1$ for every $n$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, by the Weierstrass M-test

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Yes, because $|e^(-n z)| -> 0$ at every individual point

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
No, because the sequence diverges at every point

#expl_page(include "../explanations/ca_72.typ")
#formulae_page(include "../formulae/ca_72.typ")
#steps_page(include "../solution_steps/ca_72.typ")
#prereq_page(include "../prerequisites/ca_72.typ")

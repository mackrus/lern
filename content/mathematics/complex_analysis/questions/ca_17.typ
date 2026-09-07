#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

By differentiating the Maclaurin series for $1 / (1 - z) = sum_(n=0)^oo z^n$ ($|z| < 1$), determine the series representation for $1 / (1 - z)^2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo (n + 1) z^n quad (|z| < 1) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=1)^oo n z^(n+1) quad (|z| < 1) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo (n + 2) z^n quad (|z| < 1) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo (-1)^n (n + 1) z^n quad (|z| < 1) $

#expl_page(include "../explanations/ca_17.typ")
#formulae_page(include "../formulae/ca_17.typ")
#steps_page(include "../solution_steps/ca_17.typ")
#prereq_page(include "../prerequisites/ca_17.typ")

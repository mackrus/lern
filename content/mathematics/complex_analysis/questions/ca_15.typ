#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find the Maclaurin series expansion and its radius of convergence for:
$ f(z) = z / (z^4 + 9) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo ((-1)^n) / (3^(2n+2)) z^(4n+1) quad (|z| < sqrt(3)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo (1) / (9^(n+1)) z^(4n+1) quad (|z| < 3) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo ((-1)^n) / (9^(n)) z^(4n) quad (|z| < sqrt(3)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo ((-1)^n) / (3^(n+1)) z^(2n+1) quad (|z| < 3) $

#expl_page(include "../explanations/ca_15.typ")
#formulae_page(include "../formulae/ca_15.typ")
#steps_page(include "../solution_steps/ca_15.typ")
#prereq_page(include "../prerequisites/ca_15.typ")

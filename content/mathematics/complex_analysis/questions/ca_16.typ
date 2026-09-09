#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find the Laurent series representation for $f(z) = 1 / ((z + 1)(z + 3))$ valid in the annular domain $1 < |z| < 3$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1/2 sum_(n=0)^oo ((-1)^n) / z^(n+1) - 1/6 sum_(n=0)^oo (-1/3)^n z^n $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sum_(n=0)^oo ((-1)^n) / z^(n+1) + 1/3 sum_(n=0)^oo (-1/3)^n z^n $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1/2 sum_(n=0)^oo (-1)^n z^n - 1/6 sum_(n=0)^oo (-1/3)^n z^n $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1/2 sum_(n=1)^oo ((-1)^n) / z^n + 1/2 sum_(n=0)^oo (-3)^n z^n $

#expl_page(include "../explanations/ca_16.typ")
#formulae_page(include "../formulae/ca_16.typ")
#steps_page(include "../solution_steps/ca_16.typ")
#prereq_page(include "../prerequisites/ca_16.typ")

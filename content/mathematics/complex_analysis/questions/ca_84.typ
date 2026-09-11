#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

If $f$ and $g$ are analytic functions on a connected domain $D$ and $f(z) g(z) = 0$ for all $z in D$, what must follow?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Either $f equiv 0$ on $D$ or $g equiv 0$ on $D$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Both $f$ and $g$ must have isolated zeros

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f'(z) g'(z) = 0$ for all $z in D$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f$ and $g$ can be non-zero on disjoint open subdomains of $D$

#expl_page(include "../explanations/ca_84.typ")
#formulae_page(include "../formulae/ca_84.typ")
#steps_page(include "../solution_steps/ca_84.typ")
#prereq_page(include "../prerequisites/ca_84.typ")

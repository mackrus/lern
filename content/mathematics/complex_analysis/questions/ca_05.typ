#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find all complex solutions $z$ to the equation $e^z = -2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ ln 2 + (2n + 1) pi i quad (n in ZZ) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ ln 2 + 2n pi i quad (n in ZZ) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ -ln 2 + (2n + 1) pi i quad (n in ZZ) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 2 + (2n + 1) pi i quad (n in ZZ) $

#expl_page(include "../explanations/ca_05.typ")
#formulae_page(include "../formulae/ca_05.typ")
#steps_page(include "../solution_steps/ca_05.typ")
#prereq_page(include "../prerequisites/ca_05.typ")

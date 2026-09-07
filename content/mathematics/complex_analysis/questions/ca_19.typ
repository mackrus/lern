#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find the residue $"Res"_(z=pi i) [ e^z / (z^2 + pi^2) ]$ at the simple pole $z = pi i$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ i / (2 pi) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ - i / (2 pi) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ - 1 / (2 pi) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1 / (2 pi i) $

#expl_page(include "../explanations/ca_19.typ")
#formulae_page(include "../formulae/ca_19.typ")
#steps_page(include "../solution_steps/ca_19.typ")
#prereq_page(include "../prerequisites/ca_19.typ")

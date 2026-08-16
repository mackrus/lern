#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Compute the outward flux of the vector field
$ bold(F)(x, y, z) = (x^3 + e^(y sin(z))) bold(i) + (y^3 + ln(z^2 + 1)) bold(j) + (z^3 + tan(x y)) bold(k) $
across the closed surface $S$ of the solid sphere $V$ defined by $x^2 + y^2 + z^2 <= a^2$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (12 pi a^5) / 5 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (4 pi a^5) / 5 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 4 pi a^3 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ (12 pi a^4) / 5 $

#expl_page(include "../explanations/mvc_09.typ")
#formulae_page(include "../formulae/mvc_09.typ")
#steps_page(include "../solution_steps/mvc_09.typ")
#prereq_page(include "../prerequisites/mvc_09.typ")

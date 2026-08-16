#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $Y_1$ be the surface $z = x^2 + y^2$ and $Y_2$ be the surface $z = -(x+1)^2 - y^2 + 1$. Let $gamma$ be the intersection curve of $Y_1$ and $Y_2$. Find the equations of the tangent planes to $Y_1$ and $Y_2$ at $(0, 0, 0)$, and find a parameterization of the tangent line to $gamma$ at $(0, 0, 0)$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z = 0, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l 0, t, 0 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z = 0, #h(0.5em) x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l t, 0, 0 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z = 1, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l 0, t, 0 chevron.r $#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ z = 0, #h(0.5em) 2x + z = 0, #h(0.5em) text("and line ") bold(r)(t) = chevron.l t, t, 0 chevron.r $

#expl_page(include "../explanations/mvc_29.typ")
#formulae_page(include "../formulae/mvc_29.typ")
#steps_page(include "../solution_steps/mvc_29.typ")
#prereq_page(include "../prerequisites/mvc_29.typ")

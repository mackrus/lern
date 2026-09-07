#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $f(z)$ be continuous on a closed bounded region $R$, analytic and non-constant in the interior of $R$. If $f(z) eq.not 0$ everywhere in $R$, where does $|f(z)|$ attain its minimum value?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Only on the boundary of $R$, and never in the interior.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
Always at the center of the region $R$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
At points in the interior where $f'(z) = 0$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
The minimum does not exist because $f(z) eq.not 0$.

#expl_page(include "../explanations/ca_14.typ")
#formulae_page(include "../formulae/ca_14.typ")
#steps_page(include "../solution_steps/ca_14.typ")
#prereq_page(include "../prerequisites/ca_14.typ")

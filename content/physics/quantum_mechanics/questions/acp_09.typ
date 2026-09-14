#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Let $j$ be the probability density current and $p$ be the momentum operator. $chevron.l p chevron.r = 0$ implies $j=0$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#expl_page(include "../explanations/acp_09.typ")

#steps_page(include "../solution_steps/acp_09.typ")
#prereq_page([
#include "../prerequisites/core/prac_born_rule.typ"
#include "../prerequisites/core/prac_probability_current.typ"
])

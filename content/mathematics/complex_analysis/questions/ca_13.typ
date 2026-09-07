#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Suppose $f(z)$ is an entire function such that $|f(z)| <= A |z|$ for all $z in CC$, where $A > 0$ is a fixed real constant. What can be concluded about $f(z)$?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a_1 z$ for some complex constant $a_1$ with $|a_1| <= A$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z)$ must be the zero function identically ($f equiv 0$).

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = a_1 z + a_0$ with arbitrary non-zero constant $a_0$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z)$ must be a polynomial of degree at least 2.

#expl_page(include "../explanations/ca_13.typ")
#formulae_page(include "../formulae/ca_13.typ")
#steps_page(include "../solution_steps/ca_13.typ")
#prereq_page(include "../prerequisites/ca_13.typ")

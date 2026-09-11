#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Let $Gamma_1 = {z : |z - 2 a| = a}$ ($a > 0$) and $Gamma_2 = {z : |z| = 1}$. For which values of $a$ can $Gamma_1$ and $Gamma_2$ be mapped onto two concentric circles by a Möbius transformation?

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$a in (0, 1/3) union (1, oo)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$a in (1/3, 1)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$a in (0, 1/2) union (2, oo)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
All $a > 0$

#expl_page(include "../explanations/ca_50.typ")
#formulae_page(include "../formulae/ca_50.typ")
#steps_page(include "../solution_steps/ca_50.typ")
#prereq_page(include "../prerequisites/ca_50.typ")

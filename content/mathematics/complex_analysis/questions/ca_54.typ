#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Find a conformal mapping which maps the half-disk $Omega_1 = {z : |z| < 1, "Re"(z) > 0}$ onto the strip $Omega_2 = {w : |"Re"(w)| < 1}$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (2 i) / pi "Log"(i ((z + i) / (z - i))^2)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 2 / pi "Log"((z + 1) / (z - 1))$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = (2 i) / pi ((z + i) / (z - i))^2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$f(z) = 1 / pi "Log"(z^2 + 1)$

#expl_page(include "../explanations/ca_54.typ")
#formulae_page(include "../formulae/ca_54.typ")
#steps_page(include "../solution_steps/ca_54.typ")
#prereq_page(include "../prerequisites/ca_54.typ")

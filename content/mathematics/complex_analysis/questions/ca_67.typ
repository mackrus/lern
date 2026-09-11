#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Calculate the contour integral:
$ integral_gamma (cos^2 z sin z + 2 / (2 z^2 + z - 1) + e^(z^2)) thin d z $
where $gamma$ is the closed curve defined by $z(t) = (t^2 - t + 1) e^(2 pi i t)$ for $0 <= t <= 1$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(4 pi i) / 3$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$- (2 pi i) / 3$

#expl_page(include "../explanations/ca_67.typ")
#formulae_page(include "../formulae/ca_67.typ")
#steps_page(include "../solution_steps/ca_67.typ")
#prereq_page(include "../prerequisites/ca_67.typ")

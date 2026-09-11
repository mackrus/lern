#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For any integer $k in ZZ_(>= 0)$, calculate the contour integral:
$ integral_gamma z^k e^(1/z) thin d z $
where $gamma$ is any positively oriented circle centered at the origin.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 pi i) / ((k + 1)!)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$(2 pi i) / (k!)$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i (k + 1)!$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$

#expl_page(include "../explanations/ca_91.typ")
#formulae_page(include "../formulae/ca_91.typ")
#steps_page(include "../solution_steps/ca_91.typ")
#prereq_page(include "../prerequisites/ca_91.typ")

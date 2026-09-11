#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Calculate the integral:
$ integral_gamma d z / (z (z + 1)) $
where $gamma$ is the spiral curve defined by $z(t) = e^((1 + i) t)$ for $0 <= t <= 2 pi$.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi - ln(e^(2 pi) + 1) + ln 2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i + ln 2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ln(e^(2 pi) + 1) - ln 2$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi$

#expl_page(include "../explanations/ca_65.typ")
#formulae_page(include "../formulae/ca_65.typ")
#steps_page(include "../solution_steps/ca_65.typ")
#prereq_page(include "../prerequisites/ca_65.typ")

#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

Calculate for any complex number $a$ with $|a| eq.not 1$ the value of the integral:
$ integral_(|z|=1) (z e^(z^2)) / (z - a) thin d z $
with positive orientation.

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i a e^(a^2)$ if $|a| < 1$, and $0$ if $|a| > 1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i e^(a^2)$ for all $a$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$0$ for all $a$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$2 pi i a e^(a^2)$ if $|a| > 1$, and $0$ if $|a| < 1$

#expl_page(include "../explanations/ca_63.typ")
#formulae_page(include "../formulae/ca_63.typ")
#steps_page(include "../solution_steps/ca_63.typ")
#prereq_page(include "../prerequisites/ca_63.typ")

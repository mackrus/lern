#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)

For a fixed complex number $a in CC$ and a real constant $rho > 0$, which geometric curve is represented by the equation:
$ |z|^2 - 2 "Re"(overline(a) z) + |a|^2 = rho^2 $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
A circle centered at $a$ with radius $rho$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
An ellipse with foci at $a$ and $-a$ and semi-major axis $rho$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
A straight line perpendicular to $a$ at distance $rho$ from the origin

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
A hyperbola with transverse axis along the vector $a$

#expl_page(include "../explanations/ca_26.typ")
#formulae_page(include "../formulae/ca_26.typ")
#steps_page(include "../solution_steps/ca_26.typ")
#prereq_page(include "../prerequisites/ca_26.typ")

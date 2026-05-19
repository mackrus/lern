#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
The spin Hilbert space of a single particle is four-dimensional. What is the dimension of the spin Hilbert space describing two such particles, assuming they are identical fermions sharing all other quantum numbers?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
6
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
12
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
16
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
4
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $N=4$, dimension is $N(N-1)/2 = 6$.
#prereq_page([
#include "../prerequisites/core/adv_combinatorics_of_indistinguishable_particles.typ"
#include "../prerequisites/core/adv_dimensionality.typ"
])

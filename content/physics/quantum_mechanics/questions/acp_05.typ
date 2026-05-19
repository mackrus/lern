#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Let $A$ be an operator acting on a finite-dimensional Hilbert space. What can be said about the expectation value of $A^dagger A$?
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
It is real
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
It is positive
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
It is zero
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
It is complex
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Expectation value of $A^dagger A$ is $chevron.l psi bar.v A^dagger A bar.v psi chevron.r = norm(A psi)^2 >= 0$.
#prereq_page(include "../prerequisites/advanced_conceptual.typ")

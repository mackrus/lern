#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
If the eigenvectors of an operator $M$ form an orthonormal basis, then this operator necessarily satisfies the relation $[M, M^dagger] = 0$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
True
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
False
#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Normal operators map to orthogonal eigenbases.
#prereq_page(include "../prerequisites/advanced_conceptual.typ")

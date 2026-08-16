#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- *Stokes' Theorem:*
  $ integral.cont_C bold(F) dot d bold(r) = integral.double_S (nabla times bold(F)) dot d bold(S) $
- *Curl of a Vector Field:*
  $ nabla times bold(F) = det(mat(bold(i), bold(j), bold(k); (partial) / (partial x), (partial) / (partial y), (partial) / (partial z); F_x, F_y, F_z)) $
- *Normal Vector Element for $z = g(x, y)$:*
  $ d bold(S) = chevron.l - (partial g) / (partial x), - (partial g) / (partial y), 1 chevron.r d x d y $ (upward oriented)

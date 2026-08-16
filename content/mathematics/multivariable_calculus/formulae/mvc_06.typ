#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- *Change of Variables Theorem:*
  $ integral.double_R f(x, y) d x d y = integral.double_S f(x(u, v), y(u, v)) |J(u, v)| d u d v $
- *Jacobian determinant:*
  $ J(u, v) = partial(x, y) / partial(u, v) = det(mat(partial x / partial u, partial x / partial v; partial y / partial u, partial y / partial v)) $
  and $|J(u, v)| = 1 / |det(mat(partial u / partial x, partial u / partial y; partial v / partial x, partial v / partial y))|$.

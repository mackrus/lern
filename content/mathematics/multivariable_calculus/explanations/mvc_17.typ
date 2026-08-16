#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The Jacobian matrix of the system with respect to the dependent variables $x$ and $y$ is:
$ J = mat((partial F) / (partial x), (partial F) / (partial y); (partial G) / (partial x), (partial G) / (partial y)) = mat(2x, 3y^2; y+z, x+z) $
At $(1, 1, 1)$, this matrix is $mat(2, 3; 2, 2)$, which has determinant $2(2) - 3(2) = -2$. Since the determinant is non-zero, the Implicit Function Theorem guarantees the parametrization.

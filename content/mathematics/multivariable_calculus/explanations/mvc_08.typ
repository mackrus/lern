#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

1. By Stokes' Theorem, the line integral is equal to the flux of curl of $bold(F)$ through the surface $S$ bounded by $C$:
$ integral.cont_C bold(F) dot d bold(r) = integral.double_S (nabla times bold(F)) dot d bold(S) $.

2. Compute the curl of $bold(F)$:
$ nabla times bold(F) = det(mat(bold(i), bold(j), bold(k); partial / (partial x), partial / (partial y), partial / (partial z); z^2 - y^2, x^2 - z^2, y^2 - x^2)) $
$ = bold(i)(2y - (-2z)) - bold(j)(-2x - 2z) + bold(k)(2x - (-2y)) $
$ = chevron.l 2y + 2z, 2z + 2x, 2x + 2y chevron.r $.

3. Parameterize the plane surface $S$ as $z = 3/2 - x - y$.
The upward oriented normal vector element is:
$ d bold(S) = chevron.l -partial z / partial x, -partial z / partial y, 1 chevron.r d x d y = chevron.l 1, 1, 1 chevron.r d x d y $.

4. Evaluate the dot product:
$ (nabla times bold(F)) dot d bold(S) = ( (2y + 2z)(1) + (2z + 2x)(1) + (2x + 2y)(1) ) d x d y $
$ = (4x + 4y + 4z) d x d y $.
Substituting $z = 3/2 - x - y$:
$ (nabla times bold(F)) dot d bold(S) = (4x + 4y + 4(3/2 - x - y)) d x d y = 6 d x d y $.

5. The line integral becomes:
$ integral.double_S (nabla times bold(F)) dot d bold(S) = integral.double_R 6 d x d y = 6 times "Area"(R) $.
where $R$ is the projection of the surface $S$ onto the $x y$-plane.

6. Determine "Area"(R):
The plane $x + y + z = 3/2$ intersects the unit cube boundaries. The projection region is a hexagon in the unit square $[0,1] times [0,1]$:
- Bounded by $x=0$, $y=0$, $x=1$, $y=1$.
- Cut off at bottom-left corner by $x+y=1/2$ (since $z \le 1 => x+y \ge 1/2$).
- Cut off at top-right corner by $x+y=3/2$ (since $z \ge 0 => x+y \le 3/2$).
Each removed corner triangle has side lengths $1/2$ and area $1/2 (1/2) (1/2) = 1/8$.
Thus, "Area"(R) $= 1 - 2(1/8) = 3/4$.

7. Final value $= 6 times 3/4 = 9/2$.

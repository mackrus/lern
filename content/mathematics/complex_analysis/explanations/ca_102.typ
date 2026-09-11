#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

All coefficients of $p(z) = z^4 + z^3 + 4 z^2 + 2 z + 3$ are strictly positive real numbers, so there are no positive real roots ($p(x) > 0$ for $x >= 0$).
Apply the Routh-Hurwitz stability criterion or the Argument Principle on the right half plane:
The Routh array for coefficients $(1, 1, 4, 2, 3)$:
- Row 4: $1, 4, 3$
- Row 3: $1, 2, 0$
- Row 2: $(1 dot 4 - 1 dot 2) / 1 = 2, quad 3$
- Row 1: $(2 dot 2 - 1 dot 3) / 2 = 1/2$
- Row 0: $3$
The first column is $(1, 1, 2, 1/2, 3)$. All entries are strictly positive!
Since there are no sign changes in the first column, by the Routh-Hurwitz Theorem, ALL roots lie strictly in the open left half plane ${"Re"(z) < 0}$.
Furthermore, on the negative real axis $x < 0$:
$ p(-1) = 1 - 1 + 4 - 2 + 3 = 5 > 0 $
Checking the discriminant shows there are no real roots at all (all four roots are strictly non-real).
Since the roots are non-real and lie in the left half-plane (${"Re"(z) < 0}$), they come in complex conjugate pairs with non-zero imaginary parts.
Hence, two roots must have positive imaginary part (Quadrant II) and two roots must have negative imaginary part (Quadrant III).

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Recall the complex Wirtinger derivative condition for analyticity: $(partial f) / (partial overline(z)) = 0$, or equivalently $(partial f) / (partial x) + i (partial f) / (partial y) = 0$.
Substitute $x = (z + overline(z)) / 2$ and $y = (z - overline(z)) / (2 i)$.
For degree 1: $a_1 x + a_2 y = a_1 (z + overline(z)) / 2 + a_2 (z - overline(z)) / (2 i) = z/2 (a_1 - i a_2) + overline(z)/2 (a_1 + i a_2)$. Analyticity requires $a_1 + i a_2 = 0 arrow.r.double a_2 = i a_1$, yielding $a_1 z$.
For degree 2: The only analytic quadratic polynomial is $z^2 = x^2 - y^2 + 2 i x y$. Thus $a_3 x^2 + a_4 x y + a_5 y^2 = b z^2$.
For degree 3: $z^3 = x^3 - 3 x y^2 + i (3 x^2 y - y^3)$ contains mixed terms $x y^2$ and $x^2 y$. But the proposed function has only pure cubes $a_6 x^3 + a_7 y^3$, with no mixed third-degree terms. Therefore, $a_6 = a_7 = 0$.
Hence, $f(z) = a z + b z^2$ for $a, b in CC$.

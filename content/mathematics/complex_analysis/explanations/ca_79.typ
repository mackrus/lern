#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Expand the exponent for $|z| < 1$:
$ w = z / (1 - z) = z(1 + z + z^2 + dots) = z + z^2 + O(z^3). $
Now substitute $w$ into the exponential series $e^w = 1 + w + w^2 / 2 + O(w^3)$:
$ e^(z / (1 - z)) = 1 + (z + z^2 + O(z^3)) + 1/2 (z + z^2 + O(z^3))^2 + O(z^3) $
$ = 1 + z + z^2 + 1/2 (z^2 + O(z^3)) + O(z^3) $
$ = 1 + z + (1 + 1/2) z^2 + O(z^3) $
$ = 1 + z + 3/2 z^2 + O(z^3). $
Therefore, the first three coefficients are $c_0 = 1$, $c_1 = 1$, and $c_2 = 3/2$.

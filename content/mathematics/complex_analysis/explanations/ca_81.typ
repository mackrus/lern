#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Recall the Maclaurin series for $sin z$ and $tan z$:
$ sin z = z - z^3 / 6 + O(z^5) $
$ tan z = z + z^3 / 3 + O(z^5). $
Factor out $e^(sin z)$ from $f(z)$:
$ f(z) = e^(sin z) (1 - e^(tan z - sin z)). $
Compute the difference in the exponent:
$ tan z - sin z = (z + z^3 / 3) - (z - z^3 / 6) + O(z^5) = (1/3 + 1/6) z^3 + O(z^5) = 1/2 z^3 + O(z^5). $
Now expand the exponential $e^w = 1 + w + O(w^2)$ with $w = 1/2 z^3 + O(z^5)$:
$ 1 - e^(tan z - sin z) = 1 - (1 + 1/2 z^3 + O(z^5)) = - 1/2 z^3 + O(z^5). $
Since $e^(sin 0) = e^0 = 1 eq.not 0$, we have:
$ f(z) = 1 dot (- 1/2 z^3 + O(z^5)) = - 1/2 z^3 + O(z^5). $
The first non-vanishing term in the Taylor expansion is of degree $3$. Therefore, the order of the zero at $z = 0$ is $3$.

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

For $z eq.not 1$, the geometric sum is $S_n(z) = (1 - z^(n+1)) / (1 - z)$, so $f_n(z) = (1 - z) / (1 - z^(n+1))$.
Case 1 ($|z| < 1$): $z^(n+1) -> 0$ as $n -> oo$, so $f_n(z) -> 1 - z$.
Case 2 ($|z| > 1$): $|z^(n+1)| -> oo$, so $f_n(z) -> 0$.
Case 3 ($z = 1$): $f_n(1) = 1 / (n + 1) -> 0$, which converges.
Case 4 ($|z| = 1, z eq.not 1$): $z = e^(i theta)$ with $theta eq.not 2 k pi$. Then $z^(n+1) = e^(i (n+1) theta)$ rotates around the unit circle without converging, so $f_n(z)$ diverges.
Therefore, the sequence converges for all $|z| eq.not 1$ and for $z = 1$.

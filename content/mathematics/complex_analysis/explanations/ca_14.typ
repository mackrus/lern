#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider the reciprocal function $g(z) = 1 / f(z)$.
Since $f(z) eq.not 0$ everywhere in $R$, $g(z)$ is continuous on $R$ and analytic in the interior of $R$.
By the Maximum Modulus Principle, the maximum of $|g(z)| = 1 / |f(z)|$ is attained strictly on the boundary of $R$ and never in the interior (since $f$, and hence $g$, is non-constant).
Maximizing $1 / |f(z)|$ corresponds directly to minimizing $|f(z)|$.
Therefore, $|f(z)|$ attains its minimum value exclusively on the boundary of $R$.

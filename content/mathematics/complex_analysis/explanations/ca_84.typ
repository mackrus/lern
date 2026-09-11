#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Suppose that $f$ is not identically zero on $D$.
Since $f$ is analytic and not identically zero on the connected domain $D$, its zeros must be isolated.
Let $Z(f) = {z in D : f(z) = 0}$. Then $D without Z(f)$ is a non-empty open set.
For all $z in D without Z(f)$, $f(z) eq.not 0$, so $f(z) g(z) = 0$ implies $g(z) = 0$.
Thus $g(z) = 0$ on the open set $D without Z(f)$.
An open set contains accumulation points in $D$. By the Identity Theorem, an analytic function that vanishes on an open subset of a connected domain $D$ must vanish identically on the entire domain $D$.
Hence $g(z) equiv 0$ on $D$.
Therefore, either $f equiv 0$ on $D$ or $g equiv 0$ on $D$ (the ring of analytic functions on a domain is an integral domain).

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Recall that for any $w in CC$, $2 "Re"(w) = w + overline(w)$. Here, $2 "Re"(overline(a) z) = overline(a) z + a overline(z)$.
Therefore:
$ |z - a|^2 = (z - a)(overline(z - a)) = (z - a)(overline(z) - overline(a)) = |z|^2 - overline(a) z - a overline(z) + |a|^2 = |z|^2 - 2 "Re"(overline(a) z) + |a|^2. $
The given equation is therefore identical to $|z - a|^2 = rho^2$, or $|z - a| = rho$.
This is the definition of a circle with center $a$ and radius $rho$.

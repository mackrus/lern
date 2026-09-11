#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Consider $f(z) = e^(i a z) / (z^2 + b^2)$ integrated along the standard contour in the upper half plane consisting of $[-R, R]$ and the semicircle $C_R$.
Since $a > 0$, by Jordan's Lemma, $lim_(R -> oo) integral_(C_R) f(z) d z = 0$.
The denominator has a simple pole in the upper half plane at $z = i b$.
The residue is:
$ "Res"_(z=i b) [ e^(i a z) / (z^2 + b^2) ] = [ e^(i a z) / (2 z) ]_(z = i b) = e^(i a(i b)) / (2 i b) = e^(-a b) / (2 i b). $
By the Residue Theorem:
$ integral_(-oo)^oo e^(i a x) / (x^2 + b^2) thin d x = 2 pi i dot e^(-a b) / (2 i b) = pi / b e^(-a b). $
Taking the real part:
$ integral_(-oo)^oo (cos(a x)) / (x^2 + b^2) thin d x = pi / b e^(-a b). $

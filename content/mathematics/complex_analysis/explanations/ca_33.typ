#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

By definition, $z^z = exp(z thin "log" z)$.
Here, $"log" z = ln|z| + i theta$, so:
$ z thin "log" z = (x + i y)(ln|z| + i theta) = (x ln|z| - y theta) + i (y ln|z| + x theta). $
Taking the exponential of this product:
$ z^z = e^(x ln|z| - y theta) [cos(y ln|z| + x theta) + i sin(y ln|z| + x theta)]. $
Therefore, the real part is:
$ "Re"(z^z) = e^(x ln|z| - y "arg" z) cos(y ln|z| + x "arg" z). $

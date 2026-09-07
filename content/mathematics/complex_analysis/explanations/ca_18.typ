#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Expand $f(z)$ into its Laurent series about $z = 0$ using $e^w = sum_(n=0)^oo w^n / n!$:
$ f(z) = z exp(1/z) = z sum_(n=0)^oo 1 / (n!) (1 / z)^n = z [ 1 + 1/z + 1 / (2! z^2) + 1 / (3! z^3) + dots ] $
$ f(z) = z + 1 + 1 / (2 z) + 1 / (6 z^2) + 1 / (24 z^3) + dots $
The principal part of the Laurent series (the terms with negative powers of $z$) is:
$ sum_(n=2)^oo 1 / (n!) 1 / z^(n-1) = 1 / (2z) + 1 / (6z^2) + 1 / (24z^3) + dots $
Since the principal part contains infinitely many non-zero terms, $z = 0$ is an *essential singularity*.

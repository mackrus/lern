#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

The principal value of $z^c$ is defined by $text("P.V.") thin z^c = exp(c thin "Log" z)$, where $"Log" z$ is the principal branch of the logarithm.
For $z = 1 + i$:
$ |1 + i| = sqrt(2), quad "Arg"(1 + i) = pi / 4 $
$ "Log"(1 + i) = ln sqrt(2) + i pi / 4 = 1/2 ln 2 + i pi / 4. $
Multiplying by $c = i$:
$ i thin "Log"(1 + i) = i (1/2 ln 2 + i pi/4) = - pi/4 + i (1/2 ln 2). $
Exponentiating:
$ exp(-pi/4 + i (1/2 ln 2)) = e^(-pi/4) [cos(1/2 ln 2) + i sin(1/2 ln 2)]. $

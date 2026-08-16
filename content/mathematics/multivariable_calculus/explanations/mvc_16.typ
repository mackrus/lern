#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Using the limit definition of the directional derivative and the fact that $bold(u)$ is a unit vector ($u_1^2 + u_2^2 = 1$), we have:
$ D_bold(u) f(0, 0) = lim_(t -> 0) (f(t u_1, t u_2) - f(0, 0)) / t = lim_(t -> 0) (t^3 (u_1 - u_2)^3 / t^2) / t = (u_1 - u_2)^3 $.

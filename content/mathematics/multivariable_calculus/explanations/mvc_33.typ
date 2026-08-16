#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

We express the curves as functions of $y$: the line is $x = y + 1$ and the parabola is $x = (y+1)^2$. They intersect at $y = -1$ and $y = 0$. Integrating $x_(text("right")) - x_(text("left"))$ from $y = -1$ to $y = 0$ yields:
$ integral_(-1)^0 ((y+1) - (y^2+2y+1)) d y = [ -y^3/3 - y^2/2 ]_(-1)^0 = 1/6 $.

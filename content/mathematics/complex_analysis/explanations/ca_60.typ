#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Parametrize the unit circle by $z(t) = e^(i t)$ for $0 <= t <= 2 pi$.
Then $|d z| = |i e^(i t)| d t = d t$.
The chord length is:
$ |z - 1| = |e^(i t) - 1| = |cos t - 1 + i sin t| = sqrt((cos t - 1)^2 + sin^2 t) = sqrt(2 - 2 cos t). $
Using the half-angle identity $1 - cos t = 2 sin^2(t / 2)$:
$ |z - 1| = sqrt(4 sin^2(t / 2)) = 2 |sin(t / 2)|. $
For $t in [0, 2 pi]$, $t / 2 in [0, pi]$, so $sin(t / 2) >= 0$ and $|sin(t / 2)| = sin(t / 2)$.
Now evaluate the integral:
$ integral_0^(2 pi) 2 sin(t / 2) thin d t = [ - 4 cos(t / 2) ]_0^(2 pi) = - 4 cos(pi) - (- 4 cos(0)) = 4 - (-4) = 8. $

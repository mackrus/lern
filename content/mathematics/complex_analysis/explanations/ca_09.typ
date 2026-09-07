#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Parametrize the semicircle $C$: $z(theta) = 2 e^(i theta)$ for $-pi/2 <= theta <= pi/2$.
Then:
$ d z = 2 i e^(i theta) thin d theta, quad overline(z(theta)) = 2 e^(-i theta). $
Substitute into the integral:
$ integral_C overline(z) thin d z = integral_(-pi/2)^(pi/2) (2 e^(-i theta)) (2 i e^(i theta)) thin d theta = integral_(-pi/2)^(pi/2) 4 i thin d theta = 4 i [ pi/2 - (-pi/2) ] = 4 pi i. $

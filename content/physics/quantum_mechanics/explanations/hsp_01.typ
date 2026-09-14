#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Normalization requires $1 = integral bar.v psi bar.v^2 r^2 sin(theta) d r d theta d phi$. The radial integral is $integral_0^infinity r^3 e^(-2r/a) d r = 3 a^4 / 8$. The angular integral is $4 pi$. So $A^2 (3 a^4 / 8) (4 pi) = 1 => A = sqrt(2 / (3 pi a^4))$.

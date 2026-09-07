#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- Unit circle substitutions ($z = e^(i theta)$):
  $ cos theta = (z + z^(-1)) / 2, quad sin theta = (z - z^(-1)) / (2i), quad d theta = (d z) / (i z) $
- Contour integral: $integral_0^(2pi) R(cos theta, sin theta) d theta = integral_(|z|=1) F(z) d z = 2 pi i sum_(|z_k| < 1) "Res"_(z=z_k) F(z)$

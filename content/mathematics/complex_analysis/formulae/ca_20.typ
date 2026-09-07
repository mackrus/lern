#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- Improper integral via Upper Half-Plane contour:
  $ "P.V." integral_(-oo)^oo f(x) thin d x = 2 pi i sum_("Im"(z_k) > 0) "Res"_(z=z_k) f(z) $
  when degree of denominator is at least 2 greater than degree of numerator and no real poles exist.

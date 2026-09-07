#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- Simple pole residue: $"Res"_(z=z_0) p(z)/q(z) = (p(z_0)) / (q'(z_0))$ when $p(z_0) eq.not 0, q(z_0) = 0, q'(z_0) eq.not 0$.
- General order $m$ pole residue:
  $ "Res"_(z=z_0) f(z) = 1 / ((m - 1)!) lim_(z -> z_0) (d^(m-1)) / (d z^(m-1)) [ (z - z_0)^m f(z) ] $

#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- Fourier transform contour integral:
  $ integral_(-oo)^oo f(x) sin(a x) thin d x = "Im" [ 2 pi i sum_("Im"(z_k)>0) "Res"_(z=z_k) (f(z) e^(i a z)) ] $
- Jordan's Lemma: If $|f(z)| -> 0$ as $|z| -> oo$ in upper half-plane, $lim_(R->oo) integral_(C_R) f(z) e^(i a z) d z = 0$ for $a > 0$.

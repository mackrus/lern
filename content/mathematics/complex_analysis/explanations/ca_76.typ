#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
Explanation:

Let $a_n = (n!) / n^n$. Apply the ratio test for radius of convergence: $R = lim_(n -> oo) |a_n / a_(n+1)|$.
Compute the ratio:
$ a_n / a_(n+1) = ((n!) / n^n) / (((n+1)!) / (n+1)^(n+1)) = ((n!) / n^n) dot ((n+1)^(n+1) / ((n+1) n!)) = ((n+1)^n) / n^n = ( (n + 1) / n )^n = ( 1 + 1/n )^n. $
Taking the limit as $n -> oo$:
$ R = lim_(n -> oo) ( 1 + 1/n )^n = e. $
Thus the radius of convergence is $R = e$.

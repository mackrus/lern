#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Key Formulae:*
- Term-by-term differentiation: If $f(z) = sum_(n=0)^oo a_n z^n$ for $|z| < R$, then $f'(z) = sum_(n=1)^oo n a_n z^(n-1)$ with the same radius of convergence $R$.
- Repeated differentiation: $(d^k)/(d z^k) [1/(1-z)] = (k!) / (1 - z)^(k+1) = sum_(n=k)^oo n(n-1)dots(n-k+1) z^(n-k)$

#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
Consider a particle of mass $m$ in the symmetric potential well with $V(x)=0$ for $0 <= |x| <= a$, $V(x)=V_0$ for $a < |x| < b$, and $V(x)=infinity$ for $|x| > b$. For an energy $0 < E < V_0$, which transcendental equation determines the energies of the *even* wave functions? (where $k = sqrt(2 m E)/planck$ and $kappa = sqrt(2 m (V_0-E))/planck$)

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ k tan(k a) = kappa coth( kappa (b - a)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ k tan(k a) = - kappa tanh( kappa (b - a)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ k cot(k a) = kappa tanh( kappa (b - a)) $

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ k tan(k a) = kappa tanh( kappa b) $

#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Finite Piecewise Potentials:*

- Even wave function symmetry: $psi(-x) = psi(x) => psi(x) prop cos(k x)$ in the central region.
- Boundary condition at infinite wall: $psi(plus.minus b) = 0 => psi(x) prop sinh(kappa(b-x))$ for $x > 0$.
- Matching conditions: continuity of $psi(x)$ and $psi'(x)$ at $x=a$.

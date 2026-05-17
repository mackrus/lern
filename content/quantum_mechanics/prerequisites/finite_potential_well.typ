#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Finite Piecewise Potentials:*
- Even parity wave functions: $psi(x) prop cos(k x)$ in the classically allowed region ($E > V$).
- Evanescent waves: $psi(x)$ involves $cosh(kappa x)$ or $sinh(kappa x)$ in classically forbidden regions ($E < V$).
- Boundary conditions: $psi$ and $psi'$ must be continuous at finite potential steps ($x=a$). $psi$ must be zero at infinite potential walls ($x=b$).
- Limiting cases: As $a -> b$, the barrier region vanishes, recovering an infinite square well of width $2a$.

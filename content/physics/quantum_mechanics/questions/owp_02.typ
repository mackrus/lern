#import "../../../template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A 1D harmonic oscillator of mass $m$ and frequency $omega$ is described by ladder operators $a, a^dagger$. Determine the normalized ground state wave function $Psi_0(x)$ from $a Psi_0 = 0$.
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ ( (m omega) / (pi planck) )^(1/4) e^(-(m omega x^2)/(2 planck)) $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ e^(-x^2) $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ sin(x) $
#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$ 1/sqrt(L) $
#pagebreak()
#include "../explanations/owp_02.typ"
#pagebreak()
#include "../prerequisites/oscillator_wavepacket.typ"

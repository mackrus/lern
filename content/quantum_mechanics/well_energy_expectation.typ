#import "/content/template.typ": *
#set page(width: q_width, height: auto, margin: q_margin)
#set text(size: q_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
A particle of mass $m$ in an infinite square well of width $a$ is in the state:
$ psi(x,t) = i/2 psi_1(x)e^(-i E_1 t / planck ) - 1/2 psi_2(x)e^(-i E_2 t / planck ) + 1/sqrt(2) psi_3(x)e^(-i E_3 t / planck ) $
Find the expectation value of the energy $chevron.l E chevron.r$ in terms of the ground state energy $E_1$ .

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$23/4 E_1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$14/3 E_1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$3 E_1$

#pagebreak()
#set page(width: a_width, margin: a_margin)
#set text(size: a_size)
$5 E_1$

#pagebreak()
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
*Prerequisites for Energy Expectation Values:*

- Energy eigenvalues for infinite square well: $ E_n = n^2 E_1 $
- Expectation value for discrete states: $ chevron.l E chevron.r = sum_n bar.v c_n bar.v ^2 E_n $
- Probability normalization: sum of coefficients squared equals 1

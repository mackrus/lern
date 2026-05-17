#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
*Prerequisites for 1D Infinite Square Well:*

- *Energy Eigenvalues:* For a well of width $a$ , the unperturbed energies are:
  $ E_n = n^2 E_1 = n^2 ( pi ^2 planck ^2) / (2 m a^2) $
- *Wavefunction Symmetry:* Symmetric potentials support alternating even ( $cos$ ) and odd ( $sin$ ) parity eigenfunctions.
- *Sequential Measurement:* A measurement collapses the wave function to an eigenstate of that operator. Position measurements collapse the state into a spatial delta function, which contains a superposition of ALL energy eigenstates.
- *Boundary Conditions:* Wavefunctions must vanish at boundaries where $ V(x) = infinity $ .

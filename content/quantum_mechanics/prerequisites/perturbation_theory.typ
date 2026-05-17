#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
#set list(..list_style)
#set enum(numbering: "a)", ..list_style)
*Prerequisites for Time-Independent Perturbation Theory:*

- *First-Order Energy Correction:* The first-order correction to the energy of a non-degenerate state $bar.v n chevron.r$ is $ E_n^((1)) = chevron.l n bar.v H' bar.v n chevron.r $ .
- *Second-Order Energy Correction:* The second-order correction is given by the sum over unperturbed states:
  $ E_n^((2)) = sum_(m != n) ( bar.v chevron.l m bar.v H' bar.v n chevron.r bar.v ^2) / (E_n^((0)) - E_m^((0))) $
- *Harmonic Oscillator Ladder Operators:*
  - Lowering operator: $ a bar.v n chevron.r = sqrt(n) bar.v n-1 chevron.r $
  - Raising operator: $ a^dagger bar.v n chevron.r = sqrt(n+1) bar.v n+1 chevron.r $
- *Orthogonality:* Number states are orthonormal, $ chevron.l n bar.v m chevron.r = delta_(n m) $ .

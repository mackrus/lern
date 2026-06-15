#set text(size: 20pt)
*Formula Sheet: Harmonic Oscillator Perturbations*

- *Energy Levels (Unperturbed):*
  $ E_n^((0)) = (n + 1/2) planck omega $

- *Ladder Operator Actions:*
  $ a |n chevron.r = sqrt(n) |n-1 chevron.r $
  $ a^dagger |n chevron.r = sqrt(n+1) |n+1 chevron.r $
  $ a^dagger a |n chevron.r = n |n chevron.r $

- *Multiple Ladder Actions:*
  $ a^k |n chevron.r = sqrt(n(n-1) dots (n-k+1)) |n-k chevron.r $
  $ (a^dagger)^k |n chevron.r = sqrt((n+1)(n+2) dots (n+k)) |n+k chevron.r $

- *Perturbation Formulae:*
  $ E_n^((1)) = chevron.l n | H' | n chevron.r $
  $ E_n^((2)) = sum_(m != n) (|chevron.l m | H' | n chevron.r|^2) / (E_n^((0)) - E_m^((0))) $

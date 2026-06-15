#set text(size: 20pt)
*Theoretical Prerequisites: Harmonic Oscillator & Perturbation Theory*

1. *Quantum Harmonic Oscillator:*
   - The Hamiltonian is given by:
     $ H_0 = planck omega (a^dagger a + 1/2) = planck omega (N + 1/2) $
     where $N = a^dagger a$ is the number operator.

2. *Ladder Operators:*
   - The annihilation operator $a$ and creation operator $a^dagger$ satisfy $[a, a^dagger] = 1$.
   - They act on the energy eigenstates $|n chevron.r$ as:
     $ a |n chevron.r = sqrt(n) |n-1 chevron.r $
     $ a^dagger |n chevron.r = sqrt(n+1) |n+1 chevron.r $

3. *Time-Independent Perturbation Theory:*
   - First-order correction to energy $E_n$:
     $ E_n^((1)) = chevron.l n | H' | n chevron.r $
   - Second-order correction to energy $E_n$:
     $ E_n^((2)) = sum_(m != n) (|chevron.l m | H' | n chevron.r|^2) / (E_n^((0)) - E_m^((0))) $

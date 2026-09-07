# Content Audit Report: Quantum Mechanics Problem Bank & Study Guide

## 1. Systemic Placeholder Walkthroughs (Solution Steps)
An overwhelming majority of files under `solution_steps/` suffer from a copy-paste placeholder bug. Instead of providing the actual mathematical solution steps for the specific question, they replicate a generic 4-step walkthrough for a commutator problem (`"1. Identify the commutator operator expression to evaluate..."`).

**Affected Files:**
- `solution_steps/acp_01.typ` through `solution_steps/acp_20.typ` (except where omitted)
- `solution_steps/ao_01.typ` through `solution_steps/ao_08.typ`
- `solution_steps/cf_01.typ` through `solution_steps/cf_04.typ`
- `solution_steps/cp_01.typ` through `solution_steps/cp_10.typ`
- `solution_steps/hsp_01.typ` and `solution_steps/hsp_02.typ`
- `solution_steps/owp_01.typ` through `solution_steps/owp_09.typ` (except `hydrogen_ground_probability.typ`)
- `solution_steps/pwe_01.typ` and `solution_steps/pwe_02.typ`
- `solution_steps/s1s_01.typ` and `solution_steps/s1s_02.typ`
- `solution_steps/sam_01.typ` through `solution_steps/sam_07.typ`
- `solution_steps/swe_01.typ` and `solution_steps/swe_02.typ`
- `solution_steps/wms_01.typ` and `solution_steps/wms_02.typ`

---

## 2. Invalid Walkthrough Logic
- **`solution_steps/hydrogen_ground_probability.typ`**: The walkthrough describes steps to find a *normalization constant* (setting up the integral, solving for $A$). However, the question text already provides the normalized wavefunction and asks for the *probability of measuring the ground state energy*. The steps are completely mismatched.

---

## 3. Missing Multiple-Choice Options (Blank Text fields)
Several `.typ` question files contain empty page blocks for choices, leaving options entirely blank or invisible to the student, except for the single correct option or a partial list.

- **`questions/acp_01.typ`**: Options 0, 2, and 3 are blank page blocks. Only option 1 (`$-a$`) contains text.
- **`questions/acp_10.typ`**: All options (0, 1, 2, 3) are completely blank text blocks, leaving the correct answer (`6`) invisible.
- **`questions/acp_12.typ`**: Options 0 and 2 are completely blank.
- **`questions/acp_17.typ`**: All options (0, 1, 2, 3) are completely blank text blocks, leaving the correct answer (`6`) invisible.
- **`questions/owp_08.typ`**: Options 0 and 3 are blank. Option 0 is the correct answer (`0`), making the correct answer literally invisible.
- **`questions/sam_03.typ`**: All options (0, 1, 2, 3) are completely blank text blocks, leaving the correct answer (`F=0`) invisible.
- **`questions/sam_04.typ`**: All options (0, 1, 2, 3) are completely blank text blocks, leaving the correct answer (`2`) invisible.
- **`questions/sam_05.typ`**: All options (0, 1, 2, 3) are completely blank text blocks, leaving the correct answer (`4`) invisible.
- **`questions/wms_02.typ`**: Options 1 and 2 are blank text blocks.

---

## 4. Mismatched and Irrelevant Prerequisites
Many questions include completely unrelated prerequisite `.typ` files, cluttering the layout with unhelpful equations.

- **`adv_unitary_matrices.typ` Spammed Everywhere**: This file is mistakenly included as a prerequisite for questions on completely different topics:
  - `questions/acp_14.typ` (Commutators and simultaneous diagonalization)
  - `questions/acp_19.typ` (Variational Principle)
  - `questions/cf_01.typ` (Foundational postulates of QM)
  - `questions/cp_06.typ` (Hermitian matrix eigenvalues)
  - `questions/owp_03.typ` (Quantum harmonic oscillator energy eigenvalues)
  - `questions/s1s_01.typ` & `s1s_02.typ` (Spin-1 state normalization and expectation values)
  - `questions/sam_01.typ` (Pauli matrices / spin-1/2 Zeeman Hamiltonian eigenvalues)
- **`prac_plancks_radiation_law.typ` Spammed Everywhere**: Included inappropriately for:
  - `questions/acp_11.typ` (Dimensional analysis of $\hbar, m_e, c$)
  - `questions/owp_02.typ`, `owp_04.typ`, `owp_05.typ`, `owp_06.typ`, `owp_09.typ` (Harmonic oscillator wavefunctions, bounds, or wave-packet dispersion scales)

---

## 5. Mathematical Errors in Core Prerequisites
- **`prerequisites/core/pw_even_state_transcendental_equation.typ`**:
  - *Current text*: `$k tan(k a) = kappa tanh(kappa(b-a))$`
  - *Correction*: Must be `$k tan(k a) = kappa coth(kappa(b-a))$` to properly account for the zero boundary condition at the infinite outer wall $x=b$.
- **`prerequisites/core/pw_odd_state_transcendental_equation.typ`**:
  - *Current text*: `$k cot(k a) = kappa coth(kappa(b-a))$`
  - *Correction*: Missing a negative sign. Must be `$k cot(k a) = -kappa coth(kappa(b-a))$`.

---

## 6. Typographical Errors in Table of Contents (`griffiths_toc.txt`)
- **Section 4.1**: `"4.1 The Schr ger Equation"` is missing the central letters. Fix to `"4.1 The Schrödinger Equation"`.
- **Section 8.1**: `"8.1 The Varitional Principle"` has a typo. Fix to `"8.1 The Variational Principle"`.
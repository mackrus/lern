# Content Audit Report: Thermodynamics Problem Bank & Study Guide

## 1. Mathematical & Formula Errors in Solution Steps
- **`thermodynamics/solution_steps/td_2025_06_u1.typ`**: 
  - *Error*: In step 2, the walkthrough defines the isothermal compression work as `$W_{23} = n R T_2 ln(P_2 / P_3)$`. Since $P_3 = 2 P_2$, this log yields a negative value, meaning work is done *by* the gas. However, this step is a compression where work is performed *on* the gas, so it must be positive ($+3147$ J).
  - *Fix*: Change the expression to `$W_{23} = n R T_2 ln(P_3 / P_2)$` or add a leading negative sign to invert the fraction.

## 2. Text Corruption / Typos in Source Files
- **`thermodynamics/practice_questions.txt`**:
  - *Error*: In the step-by-step explanation for **PROBLEM 1.4**, there is a bizarre text corruption within the Typst math block: `(3.0 Bird times 10^(-6) times 70^2)`. The word `"Bird"` is an invalid artifact.
  - *Fix*: Remove `"Bird"` and ensure it is formatted cleanly as a multiplication dot or symbol: `(3.0 times 10^(-6) times 70^2)`.

## 3. Systemic Misclassification in Question Metadata (`.json` files)
An overwhelming number of exam question JSON files default to Chapter 1 ("Basic Concepts") of *Finn's Thermal Physics*, completely misrepresenting advanced topics.
- **Affected Files & Solutions**:
  - `td_2025_06_u6.json` (Helmholtz Free Energy): Change chapter from `1` to `7` (`"Thermodynamic Potentials and the Maxwell Relations"`).
  - `td_2025_06_u7.json` (Partial Derivatives of Potentials): Change chapter from `1` to `7` or `8`.
  - `td_2025_06_u8.json` (Gibbs and Helmholtz Second Derivatives): Change chapter from `1` to `7`.
  - `td_2025_08_u4.json` (Liquid Mixing Entropy): Change chapter from `1` to `5` (`"Entropy"`).
  - `td_2025_08_u5.json` (Coffee/Milk Convective/Radiative Cooling): Change chapter from `1` to `13` (`"Quantum Statistics / Thermal Radiation"`).
  - `td_2025_08_u6.json` (Brake Discs Radiative Equilibrium): Change chapter from `1` to `13`.
  - `td_2025_08_u7.json` (Joule-Thomson Adiabatic Throttling): Change chapter from `1` to `3` or `8`.
  - `td_2025_08_u8.json` (Isentropic Partial Derivatives): Change chapter from `1` to `8` (`"General Thermodynamic Relations"`).

## 4. Missing References in Practice Question Schemas
- **`questions/td_p_*.json`**: All 19 practice question metadata files (from `td_p_1_2.json` to `td_p_thermal_radiation_ii_coffee_and_milk.json`) lack a `"references"` list entirely. Furthermore, their `"topics"` array is set to a completely generic `["Physics/Thermodynamics", "Practice"]`.
- *Fix*: Update the schemas to include specific book chapters and descriptive granular topics (e.g., `"Isothermal Compression"`, `"Entropy Generation"`, `"Thermometry"`).

## 5. Mismatched and Irrelevant Prerequisite Includes
Several questions link to entirely unrelated `.typ` prerequisites, adding layout clutter without providing helpful equations.
- **`questions/td_2025_08_u5.typ`**: Links to `ideal_gas_states.typ` for a problem tracking the convective and radiative cooling of liquids (coffee/milk). Re-route to `heat_transfer_modes.typ`.
- **`questions/td_2025_08_u6.typ`**: Links to `heat_engines.typ` for a problem about radiative heat dissipation of car brake discs. Re-route to `heat_transfer_modes.typ`.
- **`questions/td_p_1_2.typ`**: Links to `thermometry.typ` for a standard cylinder-piston expansion of nitrogen gas. Re-route to `ideal_gas_states.typ`.
- **`questions/td_p_3_2.typ`**: Links to `ideal_gas_states.typ` for a question regarding liquid water slowing down via viscous friction inside an insulated rigid tank. Liquid water is not an ideal gas; change to general first law/work sheets.

## 6. Numerical Rounding & Error Propagation
- **`thermodynamics/practice_questions.txt` (PROBLEM 2.6)**:
  - *Error*: The explanation rounds the initial volume $V_1$ aggressively to `0.049 m^3` (true value is `0.04923 m^3`). Re-multiplying this rounded volume by $P_1$ yields $W_{12} = -4963.7$ J instead of the exact thermodynamic value of $-4988.4$ J. This introduces an avoidable $\sim 25$ J discrepancy in the final answer ($+1951.7$ J vs exact $+1927.0$ J).
  - *Fix*: Perform the calculation algebraically ($W_{12} = -n R T_1$) to prevent intermediate rounding from corrupting the result.
import os
import re

questions_dir = "/home/mac/Projects/lern/content/physics/quantum_mechanics/questions/"
core_dir = (
    "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/core/"
)

adv_keywords = {
    "adv_operator_algebra.typ": ["commutator", "algebra"],
    "adv_expectation_values_of_products.typ": ["expectation value", "A^dagger A"],
    "adv_quantum_teleportation.typ": ["teleportation"],
    "adv_unitary_matrices.typ": ["unitary matrix"],
    "adv_hermitian_and_unitary_conditions.typ": ["Hermitian", "unitary", "eigenvalue"],
    "adv_combinatorics_of_indistinguishable_particles.typ": [
        "Bosons",
        "Fermions",
        "indistinguishable",
    ],
    "adv_bell's_inequality.typ": ["Bell", "realism"],
    "adv_normal_operators.typ": ["normal operator", "[M, M^dagger]"],
    "adv_dimensionality.typ": ["dimension", "L^("],
    "adv_units.typ": ["electron-Volt", "unit"],
    "adv_spectrum_normalization.typ": ["Dirac delta", "normalization"],
    "adv_entangled_subsystems.typ": ["entangled", "subsystem"],
}

prac_keywords = {
    "prac_born_rule.typ": ["Born", "probability density"],
    "prac_commutators.typ": ["shared", "simultaneous"],
    "prac_hermitian_operators.typ": ["anti-Hermitian"],
    "prac_maluss_law.typ": ["Malus"],
    "prac_probability_current.typ": ["current", "j(x)"],
    "prac_heisenberg_uncertainty_principle.typ": ["Heisenberg", "uncertainty"],
    "prac_plancks_radiation_law.typ": ["Planck", "blackbody"],
    "prac_stationary_time-dependence.typ": ["time-evolution", "stationary"],
    "prac_empirical_spectra.typ": ["emission lines", "history"],
    "prac_infinite_well_spectrum.typ": ["infinite well", "E_n"],
}

all_keywords = {**adv_keywords, **prac_keywords}

files = [f for f in os.listdir(questions_dir) if f.endswith(".typ")]

for filename in files:
    path = os.path.join(questions_dir, filename)
    with open(path, "r") as f:
        content = f.read()

    if os.path.exists(os.path.join(questions_dir, filename.replace(".typ", ".json"))):
        matched_prereqs = []
        for prereq, keywords in all_keywords.items():
            if any(k.lower() in content.lower() for k in keywords):
                matched_prereqs.append(prereq)

        if matched_prereqs:
            # Construct new prereq call
            includes = "\n".join(
                [f'#include "../prerequisites/core/{p}"' for p in matched_prereqs]
            )
            new_call = f"#prereq_page([\n{includes}\n])"

            # Replace old call (handles both original and partially updated formats)
            content = re.sub(r"#prereq_page\(.*?\)", new_call, content, flags=re.DOTALL)

            with open(path, "w") as f:
                f.write(content)

print("Updated question mappings.")

import os

questions_dir = "content/physics/quantum_mechanics/questions"
replacements = {
    "operators_commutators.typ": "operators_commutators_core.typ",
    "spin_angular_momentum.typ": "spin_angular_momentum_core.typ",
    "potential_wells_wavefunctions.typ": "potential_wells_wavefunctions_core.typ",
    "hydrogen_atom.typ": "hydrogen_atom_core.typ",
    "hop_shared.typ": "hop_shared_core.typ",
}

for root, _, files in os.walk(questions_dir):
    for file in files:
        if file.endswith(".typ"):
            path = os.path.join(root, file)
            with open(path, "r") as f:
                content = f.read()
            modified = False
            for old, new in replacements.items():
                if old in content:
                    content = content.replace(old, new)
                    modified = True
            if modified:
                with open(path, "w") as f:
                    f.write(content)
                print(f"Updated: {file}")

import os
import re

questions_dir = "/home/mac/Projects/lern/content/physics/quantum_mechanics/questions/"
prereqs_dir = "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/"
core_dir = (
    "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/core/"
)

# Mapping of original files to their atomic prefixes
file_to_prefix = {
    "atoms_orbitals.typ": "ao",
    "conceptual_foundations.typ": "cf",
    "harmonic_perturbation.typ": "hp",
    "hydrogen_spherical.typ": "hs",
    "oscillator_wavepacket.typ": "ow",
    "potential_wells.typ": "pw",
    "spin_1_systems.typ": "s1",
    "spin_angular_momentum.typ": "sam",
    "advanced_conceptual.typ": "adv",
    "conceptual_practice.typ": "prac",
}

# Build atomic database
# atomic_files[prefix] = list of (filename, title)
atomic_db = {}
for filename in os.listdir(core_dir):
    prefix = filename.split("_")[0]
    if prefix not in atomic_db:
        atomic_db[prefix] = []

    # Extract title from the file content
    with open(os.path.join(core_dir, filename), "r") as f:
        content = f.read()
        match = re.search(r"\*([^*:]+)\*", content)
        if match:
            title = match.group(1).strip()
            atomic_db[prefix].append((filename, title))


def update_question(filename):
    path = os.path.join(questions_dir, filename)
    with open(path, "r") as f:
        content = f.read()

    # Find all prereq_page(include "...") or prereq_page([#include ...])
    # We want to replace them with a new targeted list

    # First, find which original mega-files are "involved"
    involved_prefixes = []

    # Check for original includes
    for mega_file, prefix in file_to_prefix.items():
        if mega_file in content:
            involved_prefixes.append(prefix)

    # Check for already-atomic includes to re-evaluate them
    for prefix in atomic_db.keys():
        if f"core/{prefix}_" in content:
            if prefix not in involved_prefixes:
                involved_prefixes.append(prefix)

    if not involved_prefixes:
        return

    matched_atomics = []
    for prefix in involved_prefixes:
        if prefix in atomic_db:
            for atomic_file, title in atomic_db[prefix]:
                # Normalize title for matching: remove punctuation, lowercase
                clean_title = re.sub(r"[^a-zA-Z0-9 ]", "", title).lower()
                title_words = [w for w in clean_title.split() if len(w) > 3]

                # Match if full title in content OR most words match
                if clean_title in content.lower():
                    matched_atomics.append(atomic_file)
                else:
                    # If more than 50% of long words match, it's a hit
                    matches = [w for w in title_words if w in content.lower()]
                    if len(matches) > 0 and len(matches) >= len(title_words) / 2:
                        matched_atomics.append(atomic_file)

    if matched_atomics:
        # Sort and unique
        matched_atomics = sorted(list(set(matched_atomics)))
        includes = "\n".join(
            [f'#include "../prerequisites/core/{p}"' for p in matched_atomics]
        )
        new_call = f"#prereq_page([\n{includes}\n])"

        # Replace the entire prereq_page call
        content = re.sub(r"#prereq_page\(.*?\)", new_call, content, flags=re.DOTALL)

        with open(path, "w") as f:
            f.write(content)


# Process all questions
for filename in os.listdir(questions_dir):
    if filename.endswith(".typ"):
        update_question(filename)

print("Finished re-mapping all questions to atomic prerequisites.")

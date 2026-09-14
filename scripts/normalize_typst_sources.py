#!/usr/bin/env python3
"""Batch normalize all Typst question source files across content/."""

import os
import re
from pathlib import Path

CONTENT_DIR = Path("content")
QM_DIR = CONTENT_DIR / "physics" / "quantum_mechanics"
TD_DIR = CONTENT_DIR / "physics" / "thermodynamics"


def normalize_thermodynamics():
    """Ensure #pagebreak() precedes alternative 1 in all thermodynamics question files."""
    questions_dir = TD_DIR / "questions"
    count = 0
    for file_path in sorted(questions_dir.glob("*.typ")):
        text = file_path.read_text(encoding="utf-8")
        new_text, n = re.subn(
            r"(?<!#pagebreak\(\)\n)(?<!#pagebreak\(\))\s*(#set page\s*\(\s*width:\s*a_width)",
            r"\n#pagebreak()\n\1",
            text,
        )
        if n > 0 and new_text != text:
            file_path.write_text(new_text, encoding="utf-8")
            count += 1
    print(f"[Thermodynamics] Added missing #pagebreak() in {count} question files.")


def normalize_quantum_mechanics():
    """Extract inline explanations & prerequisites and normalize study macros in QM."""
    questions_dir = QM_DIR / "questions"
    explanations_dir = QM_DIR / "explanations"
    prerequisites_dir = QM_DIR / "prerequisites"

    explanations_dir.mkdir(parents=True, exist_ok=True)
    prerequisites_dir.mkdir(parents=True, exist_ok=True)

    extracted_expl = 0
    extracted_prereq = 0
    normalized_macros = 0

    for file_path in sorted(questions_dir.glob("*.typ")):
        base = file_path.stem
        text = file_path.read_text(encoding="utf-8")
        modified = False

        # 1. Check for inline explanation
        expl_match = re.search(
            r"#pagebreak\(\)\s*#set page\s*\([^)]*\)\s*#set text\s*\([^)]*\)\s*Explanation:\s*\n*(.*?)(?=\n#(?:formulae|steps|prereq)_page|\Z)",
            text,
            re.DOTALL,
        )
        if expl_match:
            expl_body = expl_match.group(1).strip()
            expl_file = explanations_dir / f"{base}.typ"
            if not expl_file.exists():
                expl_content = (
                    '#import "/content/template.typ": *\n'
                    "#set page(width: i_width, height: auto, margin: i_margin)\n"
                    "#set text(size: i_size)\n"
                    "Explanation:\n\n"
                    f"{expl_body}\n"
                )
                expl_file.write_text(expl_content, encoding="utf-8")
                extracted_expl += 1

            text = (
                text[: expl_match.start()]
                + f'#expl_page(include "../explanations/{base}.typ")\n'
                + text[expl_match.end() :]
            )
            modified = True

        # 2. Check for inline prerequisite in hydrogen_ground_probability.typ
        prereq_match = re.search(
            r"#prereq_page\(\[\s*(\*Prerequisites for .*?)\s*\]\)",
            text,
            re.DOTALL,
        )
        if prereq_match:
            prereq_body = prereq_match.group(1).strip()
            prereq_file = prerequisites_dir / f"{base}.typ"
            if not prereq_file.exists():
                prereq_content = (
                    '#import "/content/template.typ": *\n'
                    "#set page(width: i_width, height: auto, margin: i_margin)\n"
                    "#set text(size: i_size)\n"
                    f"{prereq_body}\n"
                )
                prereq_file.write_text(prereq_content, encoding="utf-8")
                extracted_prereq += 1

            text = (
                text[: prereq_match.start()]
                + f'#prereq_page(include "../prerequisites/{base}.typ")'
                + text[prereq_match.end() :]
            )
            modified = True

        # 3. Normalize bracket style #prereq_page([\n#include "..."\n])
        new_text, n = re.subn(
            r'#prereq_page\(\[\s*(?:#)?include\s+"([^"]+)"\s*\]\)',
            r'#prereq_page(include "\1")',
            text,
        )
        if n > 0:
            text = new_text
            normalized_macros += n
            modified = True

        text = text.rstrip() + "\n"

        if modified:
            file_path.write_text(text, encoding="utf-8")

    print(f"[Quantum Mechanics] Extracted {extracted_expl} inline explanations.")
    print(f"[Quantum Mechanics] Extracted {extracted_prereq} inline prerequisites.")
    print(f"[Quantum Mechanics] Normalized {normalized_macros} bracketed include macros.")


def main():
    print("Beginning batch normalization of Typst source files...")
    normalize_thermodynamics()
    normalize_quantum_mechanics()
    print("Batch normalization complete.")


if __name__ == "__main__":
    main()

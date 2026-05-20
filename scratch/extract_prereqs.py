import os
import re

adv_path = "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/advanced_conceptual.typ"
prac_path = "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/conceptual_practice.typ"
output_dir = (
    "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/core/"
)

header = """#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
"""


def extract(path, prefix):
    with open(path, "r") as f:
        lines = f.readlines()

    for line in lines:
        if line.startswith("- "):
            # Extract title for filename
            # Handles both "- *Title*:" and "- Title:"
            match = re.search(r"^- (?:\*)?([^*:]+)", line)
            if match:
                title = (
                    match.group(1)
                    .strip()
                    .lower()
                    .replace(" ", "_")
                    .replace("&", "and")
                    .replace(",", "")
                    .replace("(", "")
                    .replace(")", "")
                    .replace("'", "")
                )
                filename = f"{prefix}_{title}.typ"
                # Keep the content but normalize bolding if needed
                content = line.strip().replace("- ", "")
                if not content.startswith("*"):
                    # Add bolding to the title in the atomic file if it was missing
                    parts = content.split(":", 1)
                    if len(parts) == 2:
                        content = f"*{parts[0].strip()}:* {parts[1].strip()}"

                with open(os.path.join(output_dir, filename), "w") as out:
                    out.write(header + content + "\n")


extract(adv_path, "adv")
extract(prac_path, "prac")
print("Extracted atomic prerequisites.")

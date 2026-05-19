import os
import re

prereqs_dir = "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/"
output_dir = "/home/mac/Projects/lern/content/physics/quantum_mechanics/prerequisites/core/"

header = """#import "/content/template.typ": *
#set page(width: i_width, height: auto, margin: i_margin)
#set text(size: i_size)
"""

def extract(path, prefix):
    with open(path, 'r') as f:
        lines = f.readlines()
    
    for line in lines:
        if line.strip().startswith("- "):
            # Extract title for filename
            # Handles both "- *Title*:" and "- Title:"
            match = re.search(r'^- (?:\*)?([^*:]+)', line)
            if match:
                title = match.group(1).strip().lower().replace(' ', '_').replace('&', 'and').replace(',', '').replace('(', '').replace(')', '').replace("'", "").replace("/", "_")
                filename = f"{prefix}_{title}.typ"
                # Keep the content but normalize bolding if needed
                content = line.strip().replace("- ", "")
                if not content.startswith("*"):
                    # Add bolding to the title in the atomic file if it was missing
                    parts = content.split(":", 1)
                    if len(parts) == 2:
                        content = f"*{parts[0].strip()}:* {parts[1].strip()}"
                
                with open(os.path.join(output_dir, filename), 'w') as out:
                    out.write(header + content + "\n")

# Process all .typ files in prerequisites/ (except the ones already in core)
for filename in os.listdir(prereqs_dir):
    if filename.endswith(".typ"):
        prefix = "".join([part[0] for part in filename.replace(".typ", "").split("_")])
        extract(os.path.join(prereqs_dir, filename), prefix)

print("Extracted ALL atomic prerequisites.")

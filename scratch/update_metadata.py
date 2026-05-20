import os
import json


def update_metadata():
    qm_path = "content/physics/quantum_mechanics/questions"
    td_path = "content/physics/thermodynamics/questions"

    easy_prefixes = ["cp", "s1s", "cf", "owp", "wms", "td_p"]
    hard_prefixes = [
        "acp",
        "ao",
        "sam",
        "swe",
        "hsp",
        "hop",
        "pwe",
        "td_2025",
        "hydrogen",
    ]

    for path in [qm_path, td_path]:
        if not os.path.exists(path):
            continue
        for filename in os.listdir(path):
            if filename.endswith(".json"):
                file_path = os.path.join(path, filename)
                prefix = filename.split("_")[0]
                # Special case for thermodynamics prefixes like td_p or td_2025
                if filename.startswith("td_p"):
                    prefix = "td_p"
                elif filename.startswith("td_2025"):
                    prefix = "td_2025"

                difficulty = "medium"
                if prefix in easy_prefixes:
                    difficulty = "easy"
                elif prefix in hard_prefixes:
                    difficulty = "hard"

                with open(file_path, "r") as f:
                    metadata = json.load(f)

                metadata["difficulty"] = difficulty

                with open(file_path, "w") as f:
                    json.dump(metadata, f, indent=4)
                print(f"Updated {filename} with difficulty: {difficulty}")


if __name__ == "__main__":
    update_metadata()

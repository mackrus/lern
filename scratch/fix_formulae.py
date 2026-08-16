import json
import os

questions_dir = "content/physics/quantum_mechanics/questions"
targets = ["cf_03", "cf_04"] + [f"cp_{i:02d}" for i in range(1, 11)]

for target in targets:
    json_path = os.path.join(questions_dir, f"{target}.json")
    typ_path = os.path.join(questions_dir, f"{target}.typ")
    
    # 1. Update JSON
    if os.path.exists(json_path):
        with open(json_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        data["has_formulae"] = False
        with open(json_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=4, ensure_ascii=False)
            f.write("\n")
        print(f"Updated {json_path}")
        
    # 2. Update TYP
    if os.path.exists(typ_path):
        with open(typ_path, "r", encoding="utf-8") as f:
            lines = f.readlines()
        new_lines = [line for line in lines if "#formulae_page" not in line]
        with open(typ_path, "w", encoding="utf-8") as f:
            f.writelines(new_lines)
        print(f"Updated {typ_path}")

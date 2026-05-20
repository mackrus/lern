import os
import json

physics_dir = "content/physics"
for course in os.listdir(physics_dir):
    course_path = os.path.join(physics_dir, course)
    if not os.path.isdir(course_path): continue
    questions_path = os.path.join(course_path, "questions")
    if not os.path.exists(questions_path): continue
    
    for filename in os.listdir(questions_path):
        if filename.endswith(".json") and filename != "library.json":
            path = os.path.join(questions_path, filename)
            with open(path, "r") as f:
                metadata = json.load(f)
            
            # Heuristic for easy vs hard
            if filename.startswith("acp_") or filename.startswith("cp_") or filename.startswith("td_2025_"):
                metadata["difficulty"] = "easy"
            else:
                metadata["difficulty"] = "hard"
            
            with open(path, "w") as f:
                json.dump(metadata, f, indent=4)

print("Updated difficulty metadata for Physics questions.")

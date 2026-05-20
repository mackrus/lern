import os
import json
import re

# Structure: { "Category": { "course_name": [questions] } }
library = {}

content_root = "content"

for category in os.listdir(content_root):
    category_path = os.path.join(content_root, category)
    if not os.path.isdir(category_path):
        continue

    library[category.title()] = {}

    for course_dir in os.listdir(category_path):
        course_path = os.path.join(category_path, course_dir)
        if not os.path.isdir(course_path):
            continue

        questions_path = os.path.join(course_path, "questions")
        if not os.path.exists(questions_path):
            continue

        # Load course description
        course_desc = ""
        course_json_path = os.path.join(course_path, "course.json")
        if os.path.exists(course_json_path):
            with open(course_json_path, "r", encoding="utf-8") as f:
                course_desc = json.load(f).get("description", "")

        # Check for flexible library format
        lib_path = os.path.join(questions_path, "library.json")
        if os.path.exists(lib_path):
            with open(lib_path, "r", encoding="utf-8") as f:
                library_data = json.load(f)
            display_name = course_dir.replace("_", " ").title()
            library[category.title()][display_name] = {
                "type": "flexible",
                "data": library_data,
                "description": course_desc,
            }
            continue

        course_questions = []
        # Get all base filenames from content/category/course/questions/*.json
        json_files = [f for f in os.listdir(questions_path) if f.endswith(".json")]

        for json_file in json_files:
            base = json_file.replace(".json", "")
            metadata_path = os.path.join(questions_path, json_file)
            with open(metadata_path, "r") as f:
                metadata = json.load(f)
            # Collect SVG pages
            pattern = re.compile(rf"{base}-(\d+)\.svg")
            svg_files = []
            if os.path.exists("dist/content"):
                for f in os.listdir("dist/content"):
                    match = pattern.match(f)
                    if match:
                        svg_files.append((int(match.group(1)), f))

            svg_files.sort()  # Sort by page number

            if len(svg_files) < 3:
                continue

            page_contents = []
            for _, filename in svg_files:
                path = os.path.join("dist/content", filename)
                with open(path, "r") as f:
                    page_contents.append(f.read())

            num_alts = metadata.get("num_alternatives", 4)
            has_expl = metadata.get("has_explanation", False)

            question_html = page_contents[0]
            prerequisites_html = page_contents[-1]
            alternative_contents = page_contents[1 : 1 + num_alts]

            if has_expl and len(page_contents) > num_alts + 1:
                explanation_html = page_contents[num_alts + 1]
            else:
                explanation_html = None

            alternatives = []
            for i, content in enumerate(alternative_contents):
                alternatives.append(
                    {
                        "content_html": content,
                        "is_correct": i == metadata["correct_index"],
                    }
                )

            # Extract raw text from Typst files
            question_raw = ""
            typ_path = os.path.join(questions_path, f"{base}.typ")
            if os.path.exists(typ_path):
                with open(typ_path, "r") as f:
                    typ_content = f.read()
                first_page = typ_content.split("#pagebreak()")[0]
                clean_lines = [
                    line
                    for line in first_page.split("\n")
                    if not any(
                        line.startswith(p) for p in ["#import", "#set", "#include"]
                    )
                ]
                question_raw = "\n".join(clean_lines).strip()

            explanation_raw = ""
            if has_expl:
                expl_path = os.path.join(course_path, "explanations", f"{base}.typ")
                if os.path.exists(expl_path):
                    with open(expl_path, "r") as f:
                        expl_content = f.read()
                    clean_lines = [
                        line
                        for line in expl_content.split("\n")
                        if not any(
                            line.startswith(p)
                            for p in ["#import", "#set", "#include", "Explanation:"]
                        )
                    ]
                    explanation_raw = "\n".join(clean_lines).strip()
            course_questions.append(
                {
                    "id": base,
                    "label": metadata.get("label"),
                    "difficulty": metadata.get("difficulty", "medium"),
                    "topics": metadata.get("topics", []),
                    "references": metadata.get("references", []),
                    "question_html": question_html,
                    "question_raw": question_raw,
                    "prerequisites_html": prerequisites_html,
                    "explanation_html": explanation_html,
                    "explanation_raw": explanation_raw,
                    "alternatives": alternatives,
                }
            )

        if course_questions:
            display_name = course_dir.replace("_", " ").title()
            course_metadata = {}
            course_metadata_path = os.path.join(course_path, "course.json")
            if os.path.exists(course_metadata_path):
                with open(course_metadata_path, "r") as f:
                    course_metadata = json.load(f)
            
            library[category.title()][display_name] = {
                "type": "static",
                "data": course_questions,
                **course_metadata
            }

with open("dist/questions.json", "w") as out:
    json.dump(library, out)

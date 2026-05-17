import os
import json
import re

# Structure: { "course_name": [questions] }
courses = {}

content_root = "content"

for course_dir in os.listdir(content_root):
    course_path = os.path.join(content_root, course_dir)
    if not os.path.isdir(course_path):
        continue

    course_questions = []
    questions_path = os.path.join(course_path, "questions")

    if not os.path.exists(questions_path):
        continue

    # Get all base filenames from content/course/questions/*.json
    json_files = [f for f in os.listdir(questions_path) if f.endswith(".json")]

    for json_file in json_files:
        base = json_file.replace(".json", "")
        metadata_path = os.path.join(questions_path, json_file)
        with open(metadata_path, "r") as f:
            metadata = json.load(f)

        # Collect SVG pages
        pattern = re.compile(rf"{base}-(\d+)\.svg")
        svg_files = []
        for f in os.listdir("dist/content"):
            match = pattern.match(f)
            if match:
                svg_files.append((int(match.group(1)), f))

        svg_files.sort()  # Sort by page number

        if len(svg_files) < 3:
            print(f"Warning: {base}.typ has fewer than 3 pages. Skipping.")
            continue

        page_contents = []
        for _, filename in svg_files:
            path = os.path.join("dist/content", filename)
            with open(path, "r") as f:
                page_contents.append(f.read())

        num_alts = metadata.get("num_alternatives", 4)
        has_expl = metadata.get("has_explanation", False)

        # Mapping:
        # Page 0: Question
        # Page 1 to num_alts: Alternatives
        # (Optional) Page num_alts + 1: Explanation
        # Last Page: Prerequisites

        question_html = page_contents[0]
        prerequisites_html = page_contents[-1]

        alternative_contents = page_contents[1 : 1 + num_alts]

        if has_expl:
            # Explanation is expected at index num_alts + 1
            if len(page_contents) > num_alts + 1:
                explanation_html = page_contents[num_alts + 1]
            else:
                print(f"Warning: {base}.typ missing expected explanation page.")
                explanation_html = None
        else:
            explanation_html = None

        alternatives = []
        for i, content in enumerate(alternative_contents):
            alternatives.append(
                {"content_html": content, "is_correct": i == metadata["correct_index"]}
            )

        # Extract raw text from Typst files
        question_raw = ""
        typ_path = os.path.join(questions_path, f"{base}.typ")
        if os.path.exists(typ_path):
            with open(typ_path, "r") as f:
                typ_content = f.read()
            first_page = typ_content.split("#pagebreak()")[0]
            # Strip out imports and styling commands
            clean_lines = []
            for line in first_page.split("\n"):
                if (
                    not line.startswith("#import")
                    and not line.startswith("#set")
                    and not line.startswith("#include")
                ):
                    clean_lines.append(line)
            question_raw = "\n".join(clean_lines).strip()

        explanation_raw = ""
        if has_expl:
            expl_path = os.path.join(course_path, "explanations", f"{base}.typ")
            if os.path.exists(expl_path):
                with open(expl_path, "r") as f:
                    expl_content = f.read()
                clean_lines = []
                for line in expl_content.split("\n"):
                    if (
                        not line.startswith("#import")
                        and not line.startswith("#set")
                        and not line.startswith("#include")
                        and not line.startswith("Explanation:")
                    ):
                        clean_lines.append(line)
                explanation_raw = "\n".join(clean_lines).strip()

        course_questions.append(
            {
                "id": base,
                "label": metadata.get("label"),
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
        courses[display_name] = course_questions

with open("dist/questions.json", "w") as out:
    json.dump(courses, out)

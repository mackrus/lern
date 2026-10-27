import json
import os
import re

BOILERPLATE_PREFIXES = (
    "#import",
    "#include",
    "#expl_page",
    "#formulae_page",
    "#steps_page",
    "#prereq_page",
)
LAYOUT_SET_RE = re.compile(r"^#set\s+(?:page|text)\s*\(")


def is_boilerplate_line(line: str, extra_prefixes: tuple[str, ...] = ()) -> bool:
    stripped = line.strip()
    if any(stripped.startswith(p) for p in (*BOILERPLATE_PREFIXES, *extra_prefixes)):
        return True
    return bool(LAYOUT_SET_RE.match(stripped))


def clean_typst_block(text: str, extra_prefixes: tuple[str, ...] = ()) -> str:
    return "\n".join(
        line
        for line in text.split("\n")
        if not is_boilerplate_line(line, extra_prefixes)
    ).strip()


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
            with open(metadata_path, "r", encoding="utf-8") as f:
                metadata = json.load(f)
            num_alts = metadata.get("num_alternatives", 4)
            has_expl = metadata.get("has_explanation", False)
            has_formulae = metadata.get("has_formulae", False)
            has_solution_steps = metadata.get("has_solution_steps", False)
            has_prereqs = metadata.get("has_prerequisites", True)

            # Extract raw text from Typst files. Runtime rendering is handled by
            # Typst-WASM; no compiled SVG pages are needed in the question DB.
            question_raw = ""
            alt_raws = []
            typ_path = os.path.join(questions_path, f"{base}.typ")
            pages = []
            if os.path.exists(typ_path):
                with open(typ_path, "r", encoding="utf-8") as f:
                    typ_content = f.read()
                # Normalize: ensure #pagebreak() before alternatives styled with #set page(width: a_width
                normalized = re.sub(
                    r"(?<!#pagebreak\(\)\n)(?<!#pagebreak\(\))\s*(#set page\s*\(\s*width:\s*a_width)",
                    r"\n#pagebreak()\n\1",
                    typ_content,
                )
                pages = normalized.split("#pagebreak()")
                question_raw = clean_typst_block(pages[0])

                for idx, p in enumerate(pages[1 : 1 + num_alts]):
                    if idx == num_alts - 1:
                        p = re.split(
                            r"#\s*(?:expl_page|formulae_page|steps_page|prereq_page)",
                            p,
                        )[0]
                    alt_raws.append(clean_typst_block(p))

            alternatives = []
            for i in range(num_alts):
                alternatives.append(
                    {
                        "content_raw": alt_raws[i] if i < len(alt_raws) else None,
                        "is_correct": i == metadata["correct_index"],
                    }
                )

            explanation_raw = ""
            if has_expl:
                expl_path = os.path.join(course_path, "explanations", f"{base}.typ")
                if os.path.exists(expl_path):
                    with open(expl_path, "r", encoding="utf-8") as f:
                        expl_content = f.read()
                    explanation_raw = clean_typst_block(expl_content, ("Explanation:",))

                if not explanation_raw and len(pages) > 1 + num_alts:
                    raw_p = pages[1 + num_alts]
                    clean_p = re.split(
                        r"#\s*(?:formulae_page|steps_page|prereq_page)", raw_p
                    )[0]
                    explanation_raw = clean_typst_block(clean_p, ("Explanation:",))

            formulae_raw = ""
            if has_formulae:
                form_path = os.path.join(course_path, "formulae", f"{base}.typ")
                if os.path.exists(form_path):
                    with open(form_path, "r", encoding="utf-8") as f:
                        form_content = f.read()
                    formulae_raw = clean_typst_block(form_content)

            solution_steps_raw = ""
            if has_solution_steps:
                steps_path = os.path.join(course_path, "solution_steps", f"{base}.typ")
                if os.path.exists(steps_path):
                    with open(steps_path, "r", encoding="utf-8") as f:
                        steps_content = f.read()
                    solution_steps_raw = clean_typst_block(steps_content)

            prerequisites_raw = ""
            if has_prereqs:
                prereq_path = os.path.join(course_path, "prerequisites", f"{base}.typ")
                if os.path.exists(prereq_path):
                    with open(prereq_path, "r", encoding="utf-8") as f:
                        prereq_content = f.read()
                    prerequisites_raw = clean_typst_block(prereq_content)

            course_questions.append(
                {
                    "id": base,
                    "label": metadata.get("label"),
                    "difficulty": metadata.get("difficulty", "medium"),
                    "topics": metadata.get("topics", []),
                    "references": metadata.get("references", []),
                    "question_raw": question_raw,
                    "prerequisites_raw": prerequisites_raw,
                    "formulae_raw": formulae_raw,
                    "solution_steps_raw": solution_steps_raw,
                    "explanation_raw": explanation_raw,
                    "alternatives": alternatives,
                }
            )

        if course_questions:
            display_name = course_dir.replace("_", " ").title()
            course_metadata = {}
            course_metadata_path = os.path.join(course_path, "course.json")
            if os.path.exists(course_metadata_path):
                with open(course_metadata_path, "r", encoding="utf-8") as f:
                    course_metadata = json.load(f)

            library[category.title()][display_name] = {
                "type": "static",
                "data": course_questions,
                **course_metadata,
            }

with open("dist/questions.json", "w", encoding="utf-8") as out:
    json.dump(library, out)

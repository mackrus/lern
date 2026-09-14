"""Comprehensive test suite ensuring all Typst code is rendered with WASM across all modules."""

import json
import os
import re
import subprocess
import unittest
from concurrent.futures import ThreadPoolExecutor

QUESTIONS_JSON = "dist/questions.json"
WASM_COMPILER = "dist/js/typst_ts_web_compiler_bg.wasm"
WASM_RENDERER = "dist/js/typst_ts_renderer_bg.wasm"
TYPST_BUNDLE = "dist/js/typst.bundle.js"
RENDER_JS = "dist/js/render.js"
INDEX_HTML = "dist/index.html"


def compile_typst_snippet(snippet: str, kind: str = "alternative") -> tuple[bool, str]:
    """Validate that a raw Typst snippet compiles cleanly with standard header."""
    header = (
        '#let CO = $upright("CO")$\n'
        '#let CH = $upright("CH")$\n'
        '#let CaCO = $upright("CaCO")$\n'
        '#let HCO = $upright("HCO")$\n'
        '#let N_2O = $upright("N")_2 upright("O")$\n'
        '#let H_2CO = $upright("H")_2 upright("CO")$\n'
        '#let H_2O = $upright("H")_2 upright("O")$\n'
    )
    if kind == "alternative":
        header += "#set page(width: auto, height: auto, margin: 4pt)\n#set text(size: 14pt)\n"
    else:
        header += "#set page(width: 520pt, height: auto, margin: 6pt)\n#set text(size: 15pt)\n"

    full_source = header + snippet
    cmd = ["typst", "compile", "-", "-", "--format", "svg"]
    res = subprocess.run(cmd, input=full_source, text=True, capture_output=True)
    if res.returncode != 0:
        return False, res.stderr.strip()
    return True, ""


class TestTypstWasmCoverage(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if not os.path.exists(QUESTIONS_JSON):
            raise FileNotFoundError(f"Missing {QUESTIONS_JSON}. Run generate_questions.py first.")
        with open(QUESTIONS_JSON, "r", encoding="utf-8") as f:
            cls.database = json.load(f)

    def test_wasm_binaries_and_bundle_exist(self):
        """Ensure WASM binaries and client bundle are present in dist/js/."""
        self.assertTrue(os.path.exists(WASM_COMPILER), f"Missing {WASM_COMPILER}")
        self.assertTrue(os.path.exists(WASM_RENDERER), f"Missing {WASM_RENDERER}")
        self.assertTrue(os.path.exists(TYPST_BUNDLE), f"Missing {TYPST_BUNDLE}")

    def test_frontend_wires_typst_wasm(self):
        """Ensure render.js and index.html actively route rendering to typstWasm."""
        with open(RENDER_JS, "r", encoding="utf-8") as f:
            render_code = f.read()
        self.assertIn("typstWasm.compile(currentQuestion.question_raw", render_code)
        self.assertIn("typstWasm.compile(alt.content_raw", render_code)
        self.assertIn("typstWasm.compile(currentQuestion.explanation_raw", render_code)

        with open(INDEX_HTML, "r", encoding="utf-8") as f:
            html_code = f.read()
        self.assertIn('id="wasm-toggle"', html_code)

    def test_all_questions_and_alternatives_have_raw_source(self):
        """Verify that every question and alternative has non-empty raw Typst source."""
        missing = []
        total_questions = 0
        total_alternatives = 0

        for category, courses in self.database.items():
            if category == "Biology":
                continue

            for course_name, course_data in courses.items():
                questions = course_data.get("data", [])
                for q in questions:
                    total_questions += 1
                    qid = q.get("id")

                    # Question raw source
                    q_raw = q.get("question_raw")
                    if not q_raw or not q_raw.strip():
                        missing.append((course_name, qid, "question_raw"))

                    # Alternatives raw source
                    alternatives = q.get("alternatives", [])
                    self.assertGreater(
                        len(alternatives), 0, f"Question {qid} in {course_name} has no alternatives"
                    )

                    for idx, alt in enumerate(alternatives):
                        total_alternatives += 1
                        alt_raw = alt.get("content_raw")
                        if not alt_raw or not alt_raw.strip():
                            missing.append((course_name, qid, f"alternative_{idx}_content_raw"))

                    # Explanation raw source if explanation exists
                    if q.get("explanation_html") and not q.get("explanation_raw"):
                        missing.append((course_name, qid, "explanation_raw"))

        self.assertEqual(
            missing,
            [],
            f"Found {len(missing)} items missing raw Typst source for WASM rendering:\n"
            + "\n".join(f"  {m[0]} -> {m[1]} -> {m[2]}" for m in missing[:15]),
        )
        self.assertEqual(total_questions, 276)
        self.assertGreaterEqual(total_alternatives, 1000)

    def test_no_leaked_macros_or_unmatched_delimiters(self):
        """Ensure raw text does not contain leftover study macros or unmatched brackets."""
        leaked_macro_regex = re.compile(
            r"#\s*(?:expl_page|formulae_page|steps_page|prereq_page)"
        )
        failures = []

        for category, courses in self.database.items():
            if category == "Biology":
                continue

            for course_name, course_data in courses.items():
                for q in course_data.get("data", []):
                    qid = q["id"]

                    # Check alternatives
                    for idx, alt in enumerate(q.get("alternatives", [])):
                        raw = alt.get("content_raw", "")
                        if leaked_macro_regex.search(raw):
                            failures.append((qid, f"alt_{idx}", "Contains leaked macro", raw))
                        if raw.endswith("])"):
                            failures.append((qid, f"alt_{idx}", "Trailing bracket leak", raw))

                    # Check question
                    q_raw = q.get("question_raw", "")
                    if leaked_macro_regex.search(q_raw):
                        failures.append((qid, "question", "Contains leaked macro", q_raw))

        self.assertEqual(
            failures,
            [],
            f"Found {len(failures)} raw items with leaked macro syntax:\n"
            + "\n".join(f"  {f[0]} ({f[1]}): {f[2]} in {f[3]!r}" for f in failures[:10]),
        )

    def test_snippets_compile_cleanly(self):
        """Compile a representative sample of questions and alternatives across every module."""
        snippets_to_test = []
        full_mode = os.environ.get("FULL_VALIDATE") == "1"

        for category, courses in self.database.items():
            if category == "Biology":
                continue

            for course_name, course_data in courses.items():
                questions = course_data.get("data", [])
                sample_qs = questions if full_mode else questions[:8]

                for q in sample_qs:
                    qid = q["id"]
                    if q.get("question_raw"):
                        snippets_to_test.append((qid, "question", q["question_raw"]))
                    for idx, alt in enumerate(q.get("alternatives", [])):
                        if alt.get("content_raw"):
                            snippets_to_test.append((qid, f"alt_{idx}", alt["content_raw"]))

        errors = []

        def worker(item):
            qid, kind, raw = item
            ok, err = compile_typst_snippet(raw, "alternative" if "alt" in kind else "question")
            if not ok:
                return (qid, kind, raw, err)
            return None

        workers = min(os.cpu_count() or 4, 8)
        with ThreadPoolExecutor(max_workers=workers) as executor:
            for result in executor.map(worker, snippets_to_test):
                if result:
                    errors.append(result)

        self.assertEqual(
            errors,
            [],
            f"Found {len(errors)} snippets failing Typst compilation:\n"
            + "\n".join(f"  {e[0]} ({e[1]}): {e[3]}" for e in errors[:10]),
        )


if __name__ == "__main__":
    unittest.main()

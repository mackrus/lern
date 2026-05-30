use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alternative {
    pub content_html: String,
    pub is_correct: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Reference {
    pub book: String,
    pub chapter: String,
    pub topic: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Question {
    pub id: String,
    pub label: Option<String>,
    pub topics: Vec<String>,
    pub references: Vec<Reference>,
    pub question_html: String,
    pub question_raw: Option<String>,
    pub prerequisites_html: Option<String>,
    pub explanation_html: Option<String>,
    pub explanation_raw: Option<String>,
    pub is_text_input: Option<bool>,
    pub expected_answer: Option<String>,
    pub alternatives: Vec<Alternative>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopicStats {
    pub topic: String,
    pub correct: f64,
    pub total: usize,
}

pub struct Quiz {
    pub questions: Vec<Question>,
    pub current_question_index: usize,
    pub selections: Vec<Option<String>>,
    pub is_graded: bool,
}

fn deterministic_shuffle<T>(slice: &mut [T], mut seed: u64) {
    if slice.is_empty() {
        return;
    }
    for i in (1..slice.len()).rev() {
        seed = seed
            .wrapping_mul(6364136223846793005)
            .wrapping_add(1442695040888963407);
        let j = (seed >> 32) as usize % (i + 1);
        slice.swap(i, j);
    }
}

impl Quiz {
    pub fn new(mut questions: Vec<Question>) -> Self {
        for q in &mut questions {
            let mut seed = 0u64;
            for b in q.id.bytes() {
                seed = seed.wrapping_mul(31).wrapping_add(b as u64);
            }
            deterministic_shuffle(&mut q.alternatives, seed);
        }
        let len = questions.len();
        Self {
            questions,
            current_question_index: 0,
            selections: vec![None; len],
            is_graded: false,
        }
    }

    pub fn restore_state(
        &mut self,
        current_index: usize,
        selections: Vec<Option<String>>,
        is_graded: bool,
    ) {
        if current_index < self.questions.len() {
            self.current_question_index = current_index;
        }
        if selections.len() == self.questions.len() {
            self.selections = selections;
        }
        self.is_graded = is_graded;
    }

    pub fn current_question(&self) -> Option<&Question> {
        self.questions.get(self.current_question_index)
    }

    pub fn select_answer(&mut self, answer: String) {
        if self.is_graded {
            return;
        }
        if let Some(selection) = self.selections.get_mut(self.current_question_index) {
            *selection = Some(answer);
        }
    }

    pub fn get_current_selection(&self) -> Option<String> {
        self.selections
            .get(self.current_question_index)
            .and_then(|s| s.clone())
    }

    pub fn next_question(&mut self) {
        if self.questions.is_empty() {
            return;
        }
        self.current_question_index = (self.current_question_index + 1) % self.questions.len();
    }

    pub fn previous_question(&mut self) {
        if self.questions.is_empty() {
            return;
        }
        if self.current_question_index == 0 {
            self.current_question_index = self.questions.len() - 1;
        } else {
            self.current_question_index -= 1;
        }
    }

    pub fn set_question_index(&mut self, index: usize) {
        if index < self.questions.len() {
            self.current_question_index = index;
        }
    }

    pub fn current_question_index(&self) -> usize {
        self.current_question_index
    }

    pub fn total_questions(&self) -> usize {
        self.questions.len()
    }

    pub fn grade(&mut self) {
        self.is_graded = true;
    }

    pub fn get_score(&self) -> f64 {
        if !self.is_graded {
            return 0.0;
        }
        let mut score = 0.0;
        for (i, question) in self.questions.iter().enumerate() {
            let selected = self.selections.get(i).and_then(|s| s.as_ref());
            score += grade_question(question, selected.map(|s| s.as_str()));
        }
        score
    }

    pub fn get_topic_stats(&self) -> Vec<TopicStats> {
        let mut stats: std::collections::HashMap<String, (f64, usize)> =
            std::collections::HashMap::new();
        for (i, question) in self.questions.iter().enumerate() {
            let selected = self.selections.get(i).and_then(|s| s.as_ref());
            let score = grade_question(question, selected.map(|s| s.as_str()));

            for topic in &question.topics {
                let entry = stats.entry(topic.clone()).or_insert((0.0, 0));
                entry.1 += 1;
                entry.0 += score;
            }
        }

        let mut result: Vec<TopicStats> = stats
            .into_iter()
            .map(|(topic, (correct, total))| TopicStats {
                topic,
                correct,
                total,
            })
            .collect();
        result.sort_by(|a, b| a.topic.cmp(&b.topic));
        result
    }

    pub fn incorrect_question_indices(&self) -> Vec<usize> {
        if !self.is_graded {
            return Vec::new();
        }
        let mut indices = Vec::new();
        for (i, question) in self.questions.iter().enumerate() {
            let selected = self.selections.get(i).and_then(|s| s.as_ref());
            let score = grade_question(question, selected.map(|s| s.as_str()));
            if score < 1.0 {
                indices.push(i);
            }
        }
        indices
    }

    pub fn can_go_back(&self) -> bool {
        !self.questions.is_empty()
    }
}

fn levenshtein_distance(s1: &str, s2: &str) -> usize {
    let v1: Vec<char> = s1.chars().collect();
    let v2: Vec<char> = s2.chars().collect();
    let len1 = v1.len();
    let len2 = v2.len();
    
    if len1 == 0 { return len2; }
    if len2 == 0 { return len1; }
    
    let mut dp = vec![vec![0; len2 + 1]; len1 + 1];
    
    for i in 0..=len1 {
        dp[i][0] = i;
    }
    for j in 0..=len2 {
        dp[0][j] = j;
    }
    
    for i in 1..=len1 {
        for j in 1..=len2 {
            let cost = if v1[i - 1] == v2[j - 1] { 0 } else { 1 };
            dp[i][j] = std::cmp::min(
                std::cmp::min(dp[i - 1][j] + 1, dp[i][j - 1] + 1),
                dp[i - 1][j - 1] + cost
            );
        }
    }
    
    dp[len1][len2]
}

fn similarity_ratio(s1: &str, s2: &str) -> f64 {
    let len1 = s1.chars().count();
    let len2 = s2.chars().count();
    if len1 == 0 && len2 == 0 {
        return 1.0;
    }
    let max_len = std::cmp::max(len1, len2);
    let dist = levenshtein_distance(s1, s2);
    1.0 - (dist as f64) / (max_len as f64)
}

fn grade_question(question: &Question, selected: Option<&str>) -> f64 {
    if let Some(sel) = selected {
        if question.is_text_input.unwrap_or(false) {
            if let Some(expected) = &question.expected_answer {
                let sel_norm = normalize_answer(sel);
                let exp_norm = normalize_answer(expected);
                if sel_norm == exp_norm {
                    return 1.0;
                }
                let ratio = similarity_ratio(&sel_norm, &exp_norm);
                if ratio >= 0.7 {
                    return 0.5;
                }
            }
        } else if let Ok(idx) = sel.parse::<usize>() {
            if let Some(alt) = question.alternatives.get(idx) {
                if alt.is_correct {
                    return 1.0;
                }
            }
        }
    }
    0.0
}

fn normalize_answer(s: &str) -> String {
s.trim()
        .to_lowercase()
        .replace('’', "'")
        .replace('‘', "'")
        .replace('”', "\"")
        .replace('“', "\"")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_normalization() {
        assert_eq!(normalize_answer(" Korkgran "), "korkgran");
        assert_eq!(normalize_answer("Faassen’s Black"), "faassen's black");
        assert_eq!(normalize_answer("Faassen's Black"), "faassen's black");
    }

    fn sample_quiz() -> Quiz {
        let q1 = Question {
            id: "q1".to_string(),
            label: None,
            topics: vec!["Math".to_string()],
            references: vec![],
            question_html: "<p>What is 1+1?</p>".to_string(),
            question_raw: Some("What is 1+1?".to_string()),
            prerequisites_html: Some("<p>Addition</p>".to_string()),
            explanation_html: Some("<p>Because 1+1=2</p>".to_string()),
            explanation_raw: Some("Because 1+1=2".to_string()),
            is_text_input: None,
            expected_answer: None,
            alternatives: vec![
                Alternative {
                    content_html: "1".to_string(),
                    is_correct: false,
                },
                Alternative {
                    content_html: "2".to_string(),
                    is_correct: true,
                },
            ],
        };
        Quiz::new(vec![q1])
    }

    #[test]
    fn test_quiz_flow() {
        let mut quiz = sample_quiz();
        assert_eq!(quiz.current_question_index, 0);
        assert!(!quiz.is_graded);

        let correct_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(correct_idx.to_string());
        assert_eq!(quiz.get_current_selection(), Some(correct_idx.to_string()));
        assert_eq!(quiz.get_score(), 0.0, "score should be 0 before grading");
        assert!(!quiz.is_graded);

        quiz.grade();
        assert!(quiz.is_graded);
        assert_eq!(quiz.get_score(), 1.0);
    }

    #[test]
    fn test_quiz_wrong_answer() {
        let mut quiz = sample_quiz();
        // Option 0 in sample_quiz before shuffle is "1" (false)
        // Option 1 in sample_quiz before shuffle is "2" (true)
        // We must find the index of the correct alternative after shuffle to select the wrong one
        let wrong_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| !a.is_correct)
            .unwrap();
        quiz.select_answer(wrong_idx.to_string());
        assert_eq!(quiz.get_score(), 0.0);
        quiz.grade();
        assert_eq!(quiz.incorrect_question_indices(), vec![0]);
    }

    #[test]
    fn test_shuffled_grading_consistency() {
        let q1 = Question {
            id: "test_consistency_id_1".to_string(),
            label: None,
            topics: vec![],
            references: vec![],
            question_html: "Q".to_string(),
            question_raw: Some("Q".to_string()),
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
            is_text_input: None,
            expected_answer: None,
            alternatives: vec![
                Alternative {
                    content_html: "A".to_string(),
                    is_correct: false,
                },
                Alternative {
                    content_html: "B".to_string(),
                    is_correct: false,
                },
                Alternative {
                    content_html: "C".to_string(),
                    is_correct: true,
                },
                Alternative {
                    content_html: "D".to_string(),
                    is_correct: false,
                },
            ],
        };

        let mut quiz = Quiz::new(vec![q1.clone()]);

        // Find the index of the correct answer after shuffling
        let correct_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();

        quiz.select_answer(correct_idx.to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 1.0);
        assert!(quiz.incorrect_question_indices().is_empty());

        // Verify deterministic shuffle consistency (same ID -> same correct_idx)
        let quiz2 = Quiz::new(vec![q1.clone()]);
        let correct_idx2 = quiz2.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        assert_eq!(correct_idx, correct_idx2);
    }

    #[test]
    fn test_set_question_index() {
        let q1 = Question {
            id: "q1".to_string(),
            label: None,
            topics: vec![],
            references: vec![],
            question_html: "Q1".to_string(),
            question_raw: None,
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
            is_text_input: None,
            expected_answer: None,
            alternatives: vec![],
        };
        let q2 = q1.clone();
        let mut quiz = Quiz::new(vec![q1, q2]);
        
        assert_eq!(quiz.current_question_index, 0);
        quiz.set_question_index(1);
        assert_eq!(quiz.current_question_index, 1);
        quiz.set_question_index(5); // Out of bounds, should be ignored
        assert_eq!(quiz.current_question_index, 1);
    }

    // --- New comprehensive tests ---

    fn make_question(id: &str, topics: Vec<&str>, alternatives: Vec<(&str, bool)>) -> Question {
        Question {
            id: id.to_string(),
            label: None,
            topics: topics.into_iter().map(|s| s.to_string()).collect(),
            references: vec![],
            question_html: format!("<p>{}</p>", id),
            question_raw: None,
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
            is_text_input: None,
            expected_answer: None,
            alternatives: alternatives
                .into_iter()
                .map(|(html, correct)| Alternative {
                    content_html: html.to_string(),
                    is_correct: correct,
                })
                .collect(),
        }
    }

    fn make_text_question(id: &str, topics: Vec<&str>, expected: &str) -> Question {
        Question {
            id: id.to_string(),
            label: None,
            topics: topics.into_iter().map(|s| s.to_string()).collect(),
            references: vec![],
            question_html: format!("<p>{}</p>", id),
            question_raw: None,
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
            is_text_input: Some(true),
            expected_answer: Some(expected.to_string()),
            alternatives: vec![],
        }
    }

    #[test]
    fn test_empty_quiz() {
        let mut quiz = Quiz::new(vec![]);
        assert_eq!(quiz.total_questions(), 0);
        assert_eq!(quiz.current_question_index(), 0);
        assert!(quiz.current_question().is_none());
        assert_eq!(quiz.get_score(), 0.0);
        assert!(!quiz.can_go_back());

        // Navigation on empty quiz should not panic
        quiz.next_question();
        quiz.previous_question();
        assert_eq!(quiz.current_question_index(), 0);

        quiz.grade();
        assert!(quiz.incorrect_question_indices().is_empty());
    }

    #[test]
    fn test_navigation_wraps() {
        let q1 = make_question("n1", vec!["A"], vec![("X", true)]);
        let q2 = make_question("n2", vec!["A"], vec![("Y", true)]);
        let q3 = make_question("n3", vec!["A"], vec![("Z", true)]);
        let mut quiz = Quiz::new(vec![q1, q2, q3]);

        // Forward wrap: 0 -> 1 -> 2 -> 0
        assert_eq!(quiz.current_question_index(), 0);
        quiz.next_question();
        assert_eq!(quiz.current_question_index(), 1);
        quiz.next_question();
        assert_eq!(quiz.current_question_index(), 2);
        quiz.next_question();
        assert_eq!(quiz.current_question_index(), 0);

        // Backward wrap: 0 -> 2
        quiz.previous_question();
        assert_eq!(quiz.current_question_index(), 2);
        quiz.previous_question();
        assert_eq!(quiz.current_question_index(), 1);
        quiz.previous_question();
        assert_eq!(quiz.current_question_index(), 0);
    }

    #[test]
    fn test_single_question_navigation() {
        let q = make_question("solo", vec![], vec![("A", true)]);
        let mut quiz = Quiz::new(vec![q]);

        assert_eq!(quiz.current_question_index(), 0);
        quiz.next_question();
        assert_eq!(quiz.current_question_index(), 0); // wraps to 0
        quiz.previous_question();
        assert_eq!(quiz.current_question_index(), 0); // wraps to 0
    }

    #[test]
    fn test_select_answer_ignored_after_grading() {
        let q = make_question("locked", vec![], vec![("Wrong", false), ("Right", true)]);
        let mut quiz = Quiz::new(vec![q]);

        let correct_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        let wrong_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| !a.is_correct)
            .unwrap();

        quiz.select_answer(correct_idx.to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 1.0);

        // Attempt to change answer after grading — should be ignored
        quiz.select_answer(wrong_idx.to_string());
        assert_eq!(
            quiz.get_current_selection(),
            Some(correct_idx.to_string()),
            "Selection should remain locked after grading"
        );
        assert_eq!(quiz.get_score(), 1.0);
    }

    #[test]
    fn test_score_and_incorrect_consistency() {
        // This test checks that get_score() + incorrect count == total
        // after grading, for a fully-answered quiz.
        let q1 = make_question("c1", vec!["T"], vec![("A", true), ("B", false)]);
        let q2 = make_question("c2", vec!["T"], vec![("A", false), ("B", true)]);
        let q3 = make_question("c3", vec!["T"], vec![("A", false), ("B", true)]);
        let mut quiz = Quiz::new(vec![q1, q2, q3]);

        // Answer q1 correctly
        let idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        // Answer q2 wrong
        quiz.next_question();
        let idx = quiz.questions[1]
            .alternatives
            .iter()
            .position(|a| !a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        // Answer q3 correctly
        quiz.next_question();
        let idx = quiz.questions[2]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        quiz.grade();

        let score = quiz.get_score();
        let incorrect = quiz.incorrect_question_indices();
        assert_eq!(score, 2.0);
        assert_eq!(incorrect.len(), 1);
        assert_eq!(
            (score as usize) + incorrect.len(),
            quiz.total_questions(),
            "score + incorrect should equal total for a fully answered quiz"
        );
    }

    #[test]
    fn test_unanswered_questions_counted_as_incorrect() {
        // Unanswered questions have no selection. After grading,
        // incorrect_question_indices should include them.
        let q1 = make_question("u1", vec![], vec![("A", true)]);
        let q2 = make_question("u2", vec![], vec![("A", true)]);
        let mut quiz = Quiz::new(vec![q1, q2]);

        // Only answer q1
        let idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        quiz.grade();
        let incorrect = quiz.incorrect_question_indices();
        assert!(
            incorrect.contains(&1),
            "Unanswered question index 1 should be in incorrect list"
        );
        assert!(
            !incorrect.contains(&0),
            "Correctly answered question 0 should NOT be in incorrect list"
        );
    }

    #[test]
    fn test_score_before_grading_vs_after() {
        // Both get_score and incorrect_question_indices should return
        // empty/zero results before grading — they are now consistent.
        let q = make_question("pre", vec![], vec![("A", true), ("B", false)]);
        let mut quiz = Quiz::new(vec![q]);

        let correct_idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(correct_idx.to_string());

        // Before grading: both should return 0 / empty
        let score_before = quiz.get_score();
        let incorrect_before = quiz.incorrect_question_indices();

        assert_eq!(score_before, 0.0, "get_score returns 0 before grading");
        assert!(
            incorrect_before.is_empty(),
            "incorrect_question_indices returns empty before grading"
        );

        // After grading, they should be consistent
        quiz.grade();
        let score_after = quiz.get_score();
        let incorrect_after = quiz.incorrect_question_indices();
        assert_eq!(score_after, 1.0);
        assert!(incorrect_after.is_empty());
    }

    #[test]
    fn test_text_input_grading() {
        let q = make_text_question("txt1", vec!["Bio"], "Mitochondria");
        let mut quiz = Quiz::new(vec![q]);

        // Exact match (case-insensitive, trimmed)
        quiz.select_answer("  mitochondria  ".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 1.0);
    }

    #[test]
    fn test_text_input_no_expected_answer() {
        // A text-input question with no expected_answer should never score
        let q = Question {
            id: "no_exp".to_string(),
            label: None,
            topics: vec![],
            references: vec![],
            question_html: "Q".to_string(),
            question_raw: None,
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
            is_text_input: Some(true),
            expected_answer: None, // Missing!
            alternatives: vec![],
        };
        let mut quiz = Quiz::new(vec![q]);
        quiz.select_answer("anything".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 0.0);
    }

    #[test]
    fn test_topic_stats_multi_topic() {
        let q1 = make_question("mt1", vec!["Math", "Physics"], vec![("A", true)]);
        let q2 = make_question("mt2", vec!["Math"], vec![("A", false), ("B", true)]);
        let mut quiz = Quiz::new(vec![q1, q2]);

        // Answer q1 correctly
        let idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        // Answer q2 wrong
        quiz.next_question();
        let idx = quiz.questions[1]
            .alternatives
            .iter()
            .position(|a| !a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        let stats = quiz.get_topic_stats();
        let math = stats.iter().find(|s| s.topic == "Math").unwrap();
        let physics = stats.iter().find(|s| s.topic == "Physics").unwrap();

        assert_eq!(math.total, 2);
        assert_eq!(math.correct, 1.0);
        assert_eq!(physics.total, 1);
        assert_eq!(physics.correct, 1.0);
    }

    #[test]
    fn test_restore_state_valid() {
        let q1 = make_question("r1", vec![], vec![("A", true)]);
        let q2 = make_question("r2", vec![], vec![("A", true)]);
        let mut quiz = Quiz::new(vec![q1, q2]);

        quiz.restore_state(1, vec![Some("0".to_string()), None], true);
        assert_eq!(quiz.current_question_index(), 1);
        assert!(quiz.is_graded);
        assert_eq!(quiz.selections[0], Some("0".to_string()));
        assert_eq!(quiz.selections[1], None);
    }

    #[test]
    fn test_restore_state_invalid_index() {
        let q = make_question("ri", vec![], vec![]);
        let mut quiz = Quiz::new(vec![q]);

        quiz.restore_state(999, vec![None], false);
        // Out-of-bounds index should be ignored
        assert_eq!(quiz.current_question_index(), 0);
    }

    #[test]
    fn test_restore_state_wrong_selection_length() {
        let q = make_question("rs", vec![], vec![]);
        let mut quiz = Quiz::new(vec![q]);

        // selections.len() != questions.len() → should be ignored
        quiz.restore_state(0, vec![None, None, None], false);
        assert_eq!(quiz.selections.len(), 1, "Wrong-length selections should be rejected");
    }

    #[test]
    fn test_invalid_selection_index() {
        // If the user somehow selects an alternative index that doesn't exist
        let q = make_question("inv", vec![], vec![("A", true), ("B", false)]);
        let mut quiz = Quiz::new(vec![q]);

        quiz.select_answer("999".to_string()); // index 999 doesn't exist
        quiz.grade();
        assert_eq!(quiz.get_score(), 0.0, "Out-of-bounds alternative index should score 0");

        let incorrect = quiz.incorrect_question_indices();
        assert_eq!(incorrect, vec![0]);
    }

    #[test]
    fn test_non_numeric_selection_for_mc() {
        // A non-numeric string for a multiple-choice question
        let q = make_question("nan", vec![], vec![("A", true)]);
        let mut quiz = Quiz::new(vec![q]);

        quiz.select_answer("not_a_number".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 0.0, "Non-numeric selection should score 0 for MC");
    }

    #[test]
    fn test_get_current_selection_no_answer() {
        let q = make_question("nosel", vec![], vec![("A", true)]);
        let quiz = Quiz::new(vec![q]);
        assert_eq!(quiz.get_current_selection(), None);
    }

    #[test]
    fn test_deterministic_shuffle_different_ids() {
        // Different question IDs should produce different shuffle orders
        // (at least for a non-trivial number of alternatives)
        let alts: Vec<(&str, bool)> = vec![
            ("A", false),
            ("B", false),
            ("C", false),
            ("D", true),
            ("E", false),
        ];
        let q1 = make_question("alpha", vec![], alts.clone());
        let q2 = make_question("beta", vec![], alts.clone());

        let quiz1 = Quiz::new(vec![q1]);
        let quiz2 = Quiz::new(vec![q2]);

        let order1: Vec<&str> = quiz1.questions[0]
            .alternatives
            .iter()
            .map(|a| a.content_html.as_str())
            .collect();
        let order2: Vec<&str> = quiz2.questions[0]
            .alternatives
            .iter()
            .map(|a| a.content_html.as_str())
            .collect();

        // With 5 elements the chance of identical order for different seeds is ~1/120
        // This is a probabilistic assertion but extremely unlikely to fail
        assert_ne!(
            order1, order2,
            "Different IDs should (almost certainly) produce different shuffle orders"
        );
    }

    #[test]
    fn test_grade_idempotent() {
        let q = make_question("idem", vec![], vec![("A", true)]);
        let mut quiz = Quiz::new(vec![q]);

        let idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        quiz.grade();
        assert_eq!(quiz.get_score(), 1.0);

        quiz.grade(); // Grade again
        assert_eq!(quiz.get_score(), 1.0);
        assert!(quiz.is_graded);
    }

    #[test]
    fn test_mixed_mc_and_text_input() {
        let q_mc = make_question("mc", vec!["Mixed"], vec![("X", false), ("Y", true)]);
        let q_text = make_text_question("txt", vec!["Mixed"], "42");
        let mut quiz = Quiz::new(vec![q_mc, q_text]);

        // Answer MC correctly
        let idx = quiz.questions[0]
            .alternatives
            .iter()
            .position(|a| a.is_correct)
            .unwrap();
        quiz.select_answer(idx.to_string());

        // Answer text correctly
        quiz.next_question();
        quiz.select_answer("42".to_string());

        quiz.grade();
        assert_eq!(quiz.get_score(), 2.0);
        assert!(quiz.incorrect_question_indices().is_empty());

        let stats = quiz.get_topic_stats();
        let mixed = stats.iter().find(|s| s.topic == "Mixed").unwrap();
        assert_eq!(mixed.correct, 2.0);
        assert_eq!(mixed.total, 2);
    }

    #[test]
    fn test_normalize_answer_unicode_quotes() {
        // Verify all four smart-quote replacements
        assert_eq!(normalize_answer("\u{2018}test\u{2019}"), "'test'"); // ' '
        assert_eq!(normalize_answer("\u{201C}test\u{201D}"), "\"test\""); // " "
    }

    #[test]
    fn test_question_with_no_correct_alternative() {
        // Edge case: all alternatives are wrong
        let q = make_question("nocorrect", vec![], vec![("A", false), ("B", false)]);
        let mut quiz = Quiz::new(vec![q]);

        quiz.select_answer("0".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 0.0);
        assert_eq!(quiz.incorrect_question_indices(), vec![0]);
    }

    #[test]
    fn test_question_with_no_alternatives() {
        // MC question with empty alternatives vec (not text input)
        let q = make_question("empty_alts", vec![], vec![]);
        let mut quiz = Quiz::new(vec![q]);

        quiz.select_answer("0".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 0.0);
    }

    #[test]
    fn test_selection_tracks_per_question() {
        // Selecting answers on different questions should be independent
        let q1 = make_question("s1", vec![], vec![("A", true), ("B", false)]);
        let q2 = make_question("s2", vec![], vec![("X", false), ("Y", true)]);
        let mut quiz = Quiz::new(vec![q1, q2]);

        // Answer q1
        quiz.select_answer("0".to_string());
        assert_eq!(quiz.get_current_selection(), Some("0".to_string()));

        // Move to q2 and answer
        quiz.next_question();
        assert_eq!(quiz.get_current_selection(), None);
        quiz.select_answer("1".to_string());
        assert_eq!(quiz.get_current_selection(), Some("1".to_string()));

        // Go back to q1 — selection should still be there
        quiz.previous_question();
        assert_eq!(quiz.get_current_selection(), Some("0".to_string()));
    }

    #[test]
    fn test_practice_mode_no_matching_label_thermodynamics() {
        // Simulate thermodynamics: all questions labeled "exam", none "practice"
        let questions: Vec<Question> = (0..16)
            .map(|i| Question {
                id: format!("td_q{}", i),
                label: Some("exam".to_string()),
                topics: vec!["First Law".to_string()],
                references: vec![],
                question_html: format!("<p>Thermo Q{}</p>", i),
                question_raw: None,
                prerequisites_html: None,
                explanation_html: None,
                explanation_raw: None,
                is_text_input: None,
                expected_answer: None,
                alternatives: vec![
                    Alternative { content_html: "A".to_string(), is_correct: false },
                    Alternative { content_html: "B".to_string(), is_correct: true },
                ],
            })
            .collect();

        // Label-based filtering: practice mode finds nothing
        let practice_questions: Vec<&Question> = questions
            .iter()
            .filter(|q| q.label.as_deref() == Some("practice"))
            .collect();
        assert_eq!(practice_questions.len(), 0, "No practice questions → UI must hide the button");

        // Exam mode finds all 16
        let exam_questions: Vec<&Question> = questions
            .iter()
            .filter(|q| q.label.as_deref() == Some("exam"))
            .collect();
        assert_eq!(exam_questions.len(), 16, "All questions are exam-labeled");
    }

    #[test]
    fn test_levenshtein_partial_grading() {
        let q = make_text_question("lev1", vec!["Bio"], "korkgran");
        let mut quiz = Quiz::new(vec![q]);

        // Exact match -> 1.0 points
        quiz.select_answer("korkgran".to_string());
        quiz.grade();
        assert_eq!(quiz.get_score(), 1.0);

        // Spelling error slightly off (similarity ratio >= 0.7) -> 0.5 points
        // korkgarn vs korkgran has ratio 0.75
        let mut quiz2 = Quiz::new(vec![make_text_question("lev1", vec!["Bio"], "korkgran")]);
        quiz2.select_answer("korkgarn".to_string());
        quiz2.grade();
        assert_eq!(quiz2.get_score(), 0.5);
        // It should be considered incorrect/partial, so it's in incorrect indices
        assert_eq!(quiz2.incorrect_question_indices(), vec![0]);

        // Spelling error completely off (similarity ratio < 0.7) -> 0.0 points
        // kork vs korkgran has ratio 4/8 = 0.5 < 0.7
        let mut quiz3 = Quiz::new(vec![make_text_question("lev1", vec!["Bio"], "korkgran")]);
        quiz3.select_answer("kork".to_string());
        quiz3.grade();
        assert_eq!(quiz3.get_score(), 0.0);
        assert_eq!(quiz3.incorrect_question_indices(), vec![0]);
    }
}

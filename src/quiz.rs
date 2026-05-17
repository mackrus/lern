use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alternative {
    pub content_html: String,
    pub is_correct: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Question {
    pub id: String,
    pub label: Option<String>,
    pub topics: Vec<String>,
    pub question_html: String,
    pub question_raw: Option<String>,
    pub prerequisites_html: Option<String>,
    pub explanation_html: Option<String>,
    pub explanation_raw: Option<String>,
    pub alternatives: Vec<Alternative>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopicStats {
    pub topic: String,
    pub correct: usize,
    pub total: usize,
}

pub struct Quiz {
    pub questions: Vec<Question>,
    pub current_question_index: usize,
    pub selections: Vec<Option<usize>>,
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
        selections: Vec<Option<usize>>,
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

    pub fn select_answer(&mut self, alternative_index: usize) {
        if self.is_graded {
            return;
        }
        if let Some(selection) = self.selections.get_mut(self.current_question_index) {
            *selection = Some(alternative_index);
        }
    }

    pub fn get_current_selection(&self) -> Option<usize> {
        self.selections
            .get(self.current_question_index)
            .and_then(|&s| s)
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

    pub fn get_score(&self) -> usize {
        let mut score = 0;
        for (i, question) in self.questions.iter().enumerate() {
            let is_correct = self.selections.get(i)
                .and_then(|&s| s)
                .and_then(|idx| question.alternatives.get(idx))
                .map(|alt| alt.is_correct)
                .unwrap_or(false);
            if is_correct {
                score += 1;
            }
        }
        score
    }

    pub fn get_topic_stats(&self) -> Vec<TopicStats> {
        let mut stats: std::collections::HashMap<String, (usize, usize)> =
            std::collections::HashMap::new();
        for (i, question) in self.questions.iter().enumerate() {
            let is_correct = self.selections
                .get(i)
                .and_then(|&s| s)
                .and_then(|idx| question.alternatives.get(idx))
                .map(|alt| alt.is_correct)
                .unwrap_or(false);

            for topic in &question.topics {
                let entry = stats.entry(topic.clone()).or_insert((0, 0));
                entry.1 += 1;
                if is_correct {
                    entry.0 += 1;
                }
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
            let selected = self.selections.get(i).and_then(|&s| s);
            let is_correct = selected
                .and_then(|idx| question.alternatives.get(idx))
                .map(|a| a.is_correct)
                .unwrap_or(false);
            if !is_correct {
                indices.push(i);
            }
        }
        indices
    }

    pub fn can_go_back(&self) -> bool {
        !self.questions.is_empty()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn sample_quiz() -> Quiz {
        let q1 = Question {
            id: "q1".to_string(),
            label: None,
            topics: vec!["Math".to_string()],
            question_html: "<p>What is 1+1?</p>".to_string(),
            question_raw: Some("What is 1+1?".to_string()),
            prerequisites_html: Some("<p>Addition</p>".to_string()),
            explanation_html: Some("<p>Because 1+1=2</p>".to_string()),
            explanation_raw: Some("Because 1+1=2".to_string()),
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
        quiz.select_answer(correct_idx);
        assert_eq!(quiz.get_current_selection(), Some(correct_idx));
        assert_eq!(quiz.get_score(), 1);
        assert!(!quiz.is_graded);

        quiz.grade();
        assert!(quiz.is_graded);
        assert_eq!(quiz.get_score(), 1);
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
        quiz.select_answer(wrong_idx);
        assert_eq!(quiz.get_score(), 0);
        quiz.grade();
        assert_eq!(quiz.incorrect_question_indices(), vec![0]);
    }

    #[test]
    fn test_shuffled_grading_consistency() {
        let q1 = Question {
            id: "test_consistency_id_1".to_string(),
            label: None,
            topics: vec![],
            question_html: "Q".to_string(),
            question_raw: Some("Q".to_string()),
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
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

        quiz.select_answer(correct_idx);
        quiz.grade();
        assert_eq!(quiz.get_score(), 1);
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
            question_html: "Q1".to_string(),
            question_raw: None,
            prerequisites_html: None,
            explanation_html: None,
            explanation_raw: None,
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
}

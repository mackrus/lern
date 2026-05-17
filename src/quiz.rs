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
    pub question_html: String,
    pub prerequisites_html: Option<String>,
    pub explanation_html: Option<String>,
    pub alternatives: Vec<Alternative>,
}

pub struct Quiz {
    pub questions: Vec<Question>,
    pub current_question_index: usize,
    pub selections: Vec<Option<usize>>,
    pub is_graded: bool,
}

impl Quiz {
    pub fn new(questions: Vec<Question>) -> Self {
        let len = questions.len();
        Self {
            questions,
            current_question_index: 0,
            selections: vec![None; len],
            is_graded: false,
        }
    }

    pub fn restore_state(&mut self, current_index: usize, selections: Vec<Option<usize>>, is_graded: bool) {
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
        self.selections.get(self.current_question_index).and_then(|&s| s)
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
            if let Some(selection_idx) = self.selections.get(i).and_then(|&s| s) {
                if let Some(alt) = question.alternatives.get(selection_idx) {
                    if alt.is_correct {
                        score += 1;
                    }
                }
            }
        }
        score
    }

    pub fn incorrect_question_indices(&self) -> Vec<usize> {
        if !self.is_graded {
            return Vec::new();
        }
        let mut indices = Vec::new();
        for (i, question) in self.questions.iter().enumerate() {
            let selected = self.selections.get(i).and_then(|&s| s);
            let is_correct = selected.and_then(|idx| question.alternatives.get(idx)).map(|a| a.is_correct).unwrap_or(false);
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
            question_html: "<p>What is 1+1?</p>".to_string(),
            prerequisites_html: Some("<p>Addition</p>".to_string()),
            explanation_html: Some("<p>Because 1+1=2</p>".to_string()),
            alternatives: vec![
                Alternative { content_html: "1".to_string(), is_correct: false },
                Alternative { content_html: "2".to_string(), is_correct: true },
            ],
        };
        Quiz::new(vec![q1])
    }

    #[test]
    fn test_quiz_flow() {
        let mut quiz = sample_quiz();
        assert_eq!(quiz.current_question_index, 0);
        assert!(!quiz.is_graded);

        quiz.select_answer(1);
        assert_eq!(quiz.get_current_selection(), Some(1));
        assert_eq!(quiz.get_score(), 1);
        assert!(!quiz.is_graded);

        quiz.grade();
        assert!(quiz.is_graded);
        assert_eq!(quiz.get_score(), 1);
    }

    #[test]
    fn test_quiz_wrong_answer() {
        let mut quiz = sample_quiz();
        quiz.select_answer(0);
        assert_eq!(quiz.get_score(), 0);
        quiz.grade();
        assert_eq!(quiz.incorrect_question_indices(), vec![0]);
    }
}

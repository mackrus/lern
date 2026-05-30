pub mod quiz;

use wasm_bindgen::prelude::*;
use quiz::{Quiz, Question};
use std::sync::Mutex;
use once_cell::sync::Lazy;

static QUIZ_STATE: Lazy<Mutex<Option<Quiz>>> = Lazy::new(|| Mutex::new(None));

#[wasm_bindgen]
pub fn init_quiz(questions_json: &str) -> Result<(), JsValue> {
    let questions: Vec<Question> = serde_json::from_str(questions_json)
        .map_err(|e| JsValue::from_str(&e.to_string()))?;
    
    let mut state = QUIZ_STATE.lock().unwrap();
    *state = Some(Quiz::new(questions));
    Ok(())
}

#[wasm_bindgen]
pub fn restore_quiz_state(current_index: usize, selections_json: &str, is_graded: bool) -> Result<(), JsValue> {
    let selections: Vec<Option<String>> = serde_json::from_str(selections_json)
        .map_err(|e| JsValue::from_str(&e.to_string()))?;
    
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.restore_state(current_index, selections, is_graded);
    }
    Ok(())
}

#[wasm_bindgen]
pub fn get_selections_json() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| serde_json::to_string(&s.selections).unwrap())
}

#[wasm_bindgen]
pub fn get_current_question_id() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().map(|q| q.id.clone())
}

#[wasm_bindgen]
pub fn get_current_question_label() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().and_then(|q| q.label.clone())
}

#[wasm_bindgen]
pub fn get_current_question_html() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().map(|q| q.question_html.clone())
}

#[wasm_bindgen]
pub fn get_current_question_raw() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().and_then(|q| q.question_raw.clone())
}

#[wasm_bindgen]
pub fn get_current_question_explanation_raw() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().and_then(|q| q.explanation_raw.clone())
}

#[wasm_bindgen]
pub fn get_current_question_prerequisites_html() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().and_then(|q| q.prerequisites_html.clone())
}

#[wasm_bindgen]
pub fn get_current_question_explanation_html() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().and_then(|q| q.explanation_html.clone())
}

#[wasm_bindgen]
pub fn get_current_question_references_json() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question().map(|q| serde_json::to_string(&q.references).unwrap())
}

#[wasm_bindgen]
pub fn is_graded() -> bool {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.is_graded).unwrap_or(false)
}

#[wasm_bindgen]
pub fn grade_quiz() {
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.grade();
    }
}

#[wasm_bindgen]
pub fn select_answer(answer: String) {
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.select_answer(answer);
    }
}

#[wasm_bindgen]
pub fn get_current_selection() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.get_current_selection()
}

#[wasm_bindgen]
pub fn next_question() {
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.next_question();
    }
}

#[wasm_bindgen]
pub fn previous_question() {
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.previous_question();
    }
}

#[wasm_bindgen]
pub fn set_question_index(index: usize) {
    let mut state = QUIZ_STATE.lock().unwrap();
    if let Some(quiz) = state.as_mut() {
        quiz.set_question_index(index);
    }
}

#[wasm_bindgen]
pub fn can_go_back() -> bool {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.can_go_back()).unwrap_or(false)
}

#[wasm_bindgen]
pub fn get_alternatives_count() -> usize {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().and_then(|s| s.current_question()).map(|q| q.alternatives.len()).unwrap_or(0)
}

#[wasm_bindgen]
pub fn get_alternative_html(index: usize) -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.current_question()?.alternatives.get(index).map(|a| a.content_html.clone())
}

#[wasm_bindgen]
pub fn is_alternative_correct(index: usize) -> bool {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()
        .and_then(|s| s.current_question())
        .and_then(|q| q.alternatives.get(index))
        .map(|a| a.is_correct)
        .unwrap_or(false)
}

#[wasm_bindgen]
pub fn is_finished() -> bool {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.is_graded).unwrap_or(true)
}

#[wasm_bindgen]
pub fn get_current_question_index() -> usize {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.current_question_index()).unwrap_or(0)
}

#[wasm_bindgen]
pub fn get_total_questions() -> usize {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.total_questions()).unwrap_or(0)
}

#[wasm_bindgen]
pub fn get_incorrect_indices() -> Vec<usize> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.incorrect_question_indices()).unwrap_or_default()
}

#[wasm_bindgen]
pub fn get_question_html_by_index(index: usize) -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.questions.get(index).map(|q| q.question_html.clone())
}

#[wasm_bindgen]
pub fn get_explanation_html_by_index(index: usize) -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.questions.get(index).and_then(|q| q.explanation_html.clone())
}

#[wasm_bindgen]
pub fn get_references_json_by_index(index: usize) -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref()?.questions.get(index).map(|q| serde_json::to_string(&q.references).unwrap())
}

#[wasm_bindgen]
pub fn get_score() -> f64 {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| s.get_score()).unwrap_or(0.0)
}

#[wasm_bindgen]
pub fn get_topic_stats_json() -> Option<String> {
    let state = QUIZ_STATE.lock().unwrap();
    state.as_ref().map(|s| serde_json::to_string(&s.get_topic_stats()).unwrap())
}

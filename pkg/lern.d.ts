/* tslint:disable */
/* eslint-disable */

export function can_go_back(): boolean;

export function get_alternative_html(index: number): string | undefined;

export function get_alternatives_count(): number;

export function get_current_question_explanation_html(): string | undefined;

export function get_current_question_explanation_raw(): string | undefined;

export function get_current_question_html(): string | undefined;

export function get_current_question_id(): string | undefined;

export function get_current_question_index(): number;

export function get_current_question_label(): string | undefined;

export function get_current_question_prerequisites_html(): string | undefined;

export function get_current_question_raw(): string | undefined;

export function get_current_question_references_json(): string | undefined;

export function get_current_selection(): string | undefined;

export function get_explanation_html_by_index(index: number): string | undefined;

export function get_incorrect_indices(): Uint32Array;

export function get_question_html_by_index(index: number): string | undefined;

export function get_references_json_by_index(index: number): string | undefined;

export function get_score(): number;

export function get_selections_json(): string | undefined;

export function get_topic_stats_json(): string | undefined;

export function get_total_questions(): number;

export function grade_quiz(): void;

export function init_quiz(questions_json: string): void;

export function is_finished(): boolean;

export function is_graded(): boolean;

export function next_question(): void;

export function previous_question(): void;

export function restore_quiz_state(current_index: number, selections_json: string, is_graded: boolean): void;

export function select_answer(answer: string): void;

export function set_question_index(index: number): void;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
    readonly memory: WebAssembly.Memory;
    readonly can_go_back: () => number;
    readonly get_alternative_html: (a: number) => [number, number];
    readonly get_alternatives_count: () => number;
    readonly get_current_question_explanation_html: () => [number, number];
    readonly get_current_question_explanation_raw: () => [number, number];
    readonly get_current_question_html: () => [number, number];
    readonly get_current_question_id: () => [number, number];
    readonly get_current_question_label: () => [number, number];
    readonly get_current_question_prerequisites_html: () => [number, number];
    readonly get_current_question_raw: () => [number, number];
    readonly get_current_question_references_json: () => [number, number];
    readonly get_current_selection: () => [number, number];
    readonly get_explanation_html_by_index: (a: number) => [number, number];
    readonly get_incorrect_indices: () => [number, number];
    readonly get_question_html_by_index: (a: number) => [number, number];
    readonly get_references_json_by_index: (a: number) => [number, number];
    readonly get_selections_json: () => [number, number];
    readonly get_topic_stats_json: () => [number, number];
    readonly get_total_questions: () => number;
    readonly init_quiz: (a: number, b: number) => [number, number];
    readonly is_finished: () => number;
    readonly is_graded: () => number;
    readonly restore_quiz_state: (a: number, b: number, c: number, d: number) => [number, number];
    readonly select_answer: (a: number, b: number) => void;
    readonly grade_quiz: () => void;
    readonly get_current_question_index: () => number;
    readonly previous_question: () => void;
    readonly get_score: () => number;
    readonly next_question: () => void;
    readonly set_question_index: (a: number) => void;
    readonly __wbindgen_externrefs: WebAssembly.Table;
    readonly __wbindgen_free: (a: number, b: number, c: number) => void;
    readonly __wbindgen_malloc: (a: number, b: number) => number;
    readonly __wbindgen_realloc: (a: number, b: number, c: number, d: number) => number;
    readonly __externref_table_dealloc: (a: number) => void;
    readonly __wbindgen_start: () => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;

/**
 * Instantiates the given `module`, which can either be bytes or
 * a precompiled `WebAssembly.Module`.
 *
 * @param {{ module: SyncInitInput }} module - Passing `SyncInitInput` directly is deprecated.
 *
 * @returns {InitOutput}
 */
export function initSync(module: { module: SyncInitInput } | SyncInitInput): InitOutput;

/**
 * If `module_or_path` is {RequestInfo} or {URL}, makes a request and
 * for everything else, calls `WebAssembly.instantiate` directly.
 *
 * @param {{ module_or_path: InitInput | Promise<InitInput> }} module_or_path - Passing `InitInput` directly is deprecated.
 *
 * @returns {Promise<InitOutput>}
 */
export default function __wbg_init (module_or_path?: { module_or_path: InitInput | Promise<InitInput> } | InitInput | Promise<InitInput>): Promise<InitOutput>;

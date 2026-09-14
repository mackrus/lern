import assert from "node:assert/strict";
import fs from "node:fs";
import {
    Complex,
    cleanTypstMath,
    evaluateMath,
    isNumericalQuestion,
    matchAlternative
} from "../dist/js/math-evaluator.js";

console.log("Running math-evaluator test suite...");

// 1. Implicit multiplication & equivalence
const v1 = evaluateMath("2pi");
const v2 = evaluateMath("2*pi");
assert(v1 !== null, "2pi should evaluate");
assert(v2 !== null, "2*pi should evaluate");
assert(v1.equals(v2), "2pi must be interpreted the same as 2*pi");
assert.equal(Number(v1.re.toFixed(6)), Number((2 * Math.PI).toFixed(6)));

// 2. Complex and negative numbers
const c1 = evaluateMath("4i");
const c2 = evaluateMath("4*i");
assert(c1.equals(c2), "4i must equal 4*i");
assert.equal(c1.re, 0);
assert.equal(c1.im, 4);

const c3 = evaluateMath("2pi i");
const c4 = evaluateMath("2 * pi * i");
assert(c3.equals(c4), "2pi i must equal 2*pi*i");

const c5 = evaluateMath("i^2");
assert(c5.equals(new Complex(-1, 0)), "i^2 must equal -1");

// 3. Functions & powers
const p1 = evaluateMath("e^2");
assert(p1.equals(new Complex(Math.E * Math.E, 0)), "e^2 must equal Math.E^2");

const s1 = evaluateMath("sqrt(4)");
assert(s1.equals(new Complex(2, 0)), "sqrt(4) must equal 2");

const s2 = evaluateMath("3sqrt(2)");
const s3 = evaluateMath("3 * sqrt(2)");
assert(s2.equals(s3), "3sqrt(2) must equal 3*sqrt(2)");

const f1 = evaluateMath("(2 pi) / 3");
const f2 = evaluateMath("2pi/3");
const f3 = evaluateMath("2*pi/3");
assert(f1.equals(f2), "(2 pi) / 3 must equal 2pi/3");
assert(f2.equals(f3), "2pi/3 must equal 2*pi/3");

// 4. Test question detection on questions.json
const db = JSON.parse(fs.readFileSync("dist/questions.json", "utf8"));
const caQuestions = db["Mathematics"]["Complex Analysis"].data;

const ca01 = caQuestions.find(q => q.id === "ca_01");
const ca02 = caQuestions.find(q => q.id === "ca_02");
const ca03 = caQuestions.find(q => q.id === "ca_03");

assert.equal(isNumericalQuestion(ca01), false, "ca_01 (complex identity) is not a numerical question");
assert.equal(isNumericalQuestion(ca02), true, "ca_02 (-4, 4i, -4i, 4) is a numerical question");
assert.equal(isNumericalQuestion(ca03), true, "ca_03 (angles in radians) is a numerical question");

// 5. Test matchAlternative for ca_03: (2 pi) / 3 is alt 0
const match1 = matchAlternative("2pi/3", ca03);
assert.equal(match1.matchedIndex, 0, "2pi/3 must match alt 0 of ca_03");

const match2 = matchAlternative("2*pi/3", ca03);
assert.equal(match2.matchedIndex, 0, "2*pi/3 must match alt 0 of ca_03");

const match3 = matchAlternative("-pi/3", ca03);
assert.equal(match3.matchedIndex, 1, "-pi/3 must match alt 1 of ca_03");

// 6. Test matchAlternative for ca_02: -4 is alt 0, 4i is alt 1
const match4 = matchAlternative("4i", ca02);
assert.equal(match4.matchedIndex, 1, "4i must match alt 1 of ca_02");

const match5 = matchAlternative("4*i", ca02);
assert.equal(match5.matchedIndex, 1, "4*i must match alt 1 of ca_02");

console.log("All math-evaluator tests passed successfully!");

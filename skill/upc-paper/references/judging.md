# How UPC Papers Are Judged (and How to Self-Score)

There is no published rubric — only the contest rules and the 74 Gold Medal papers. This file turns both into a working scoring model. Treat the weights as a planning tool, not as fact.

## 1. What the rules explicitly require

Scoring follows from the rules: a paper that violates them loses points regardless of physics quality.

1. Every page carries the team number at the top.
2. Page 1 has exactly four items: team number, problem letter, title, Summary ≤300 words that states the approach, the assumptions, the answers to every question with numbers, and the conclusion.
3. No names, school names or identifying marks anywhere.
4. The body restates the problem, states **all** assumptions, justifies **every** step, and discusses strengths and weaknesses.
5. A reference list with in-text citations.
6. Axes labelled with physical quantities and units; units and significant figures consistent.
7. Code, if used, in an appendix — but the method must be described in the body.
8. Generative AI, if used, declared at the end with system, verbatim prompts and full outputs.
9. Filename `<team><problem>.pdf`.

## 2. The five things judges actually weigh

Derived from reading the corpus: the papers that win answer all questions quantitatively, justify their assumptions, validate, and read cleanly.

| Dimension | Weight | What "full marks" looks like | Typical loss |
|---|---|---|---|
| Answers to every question | 30 | each sub-question answered with a number, unit, uncertainty, and a sentence of interpretation | one sub-question answered qualitatively, or "we did not model X" |
| Model and assumptions | 20 | layered model, each assumption with a magnitude check, dimensional analysis, governing equations derived not cited | assumptions listed but not justified; equations appear from nowhere |
| Validation and error | 15 | comparison with external data or a limiting case, error budget with a dominant term, sensitivity | "the results look reasonable" |
| Structure and clarity | 15 | question-by-question structure, summary that answers, figures that carry claims | wandering sections, summary that describes instead of answers |
| Presentation | 10 | consistent typography, labelled axes, booktabs tables, clean references | unlabelled axes, inconsistent units, broken references |
| Background and references | 10 | 8–12 sources actually used, placed in context | five Wikipedia links, or 30 uncited references |

## 3. What separates Gold from Silver

From the corpus, Gold papers consistently do four things:

1. **A quantitative answer chain.** Every claim ends in a number with a unit; the summary repeats those numbers.
2. **Assumptions with consequences.** Not "we neglect drag" but "neglecting drag overestimates the range by 12% at launch; we include it in Sec. 4.2".
3. **At least one external check.** A published experiment, a known constant, a limit case, a simulation cross-check.
4. **A short, sharp summary.** 200–280 words, structured as situation → model → answers → validation → uncertainty.

Silver papers typically: model correctly but never validate; write 40 pages with 6 figures; bury answers in prose; list assumptions without numbers.

## 4. Common deductions (seen across the corpus)

- Summary over 300 words (rule violation, cheap loss).
- Summary that describes the paper ("In this paper we discuss…") instead of answering.
- Answers only for the "main" case; the parameter sweep is missing.
- Units missing on axes, or `T (K)` written as `Temperature`.
- Figures with default styles, unreadable at print size.
- References cited only in the introduction.
- Overfull lines pushing text into the margin.
- Team number missing from later pages (header forgotten after page 1).
- Appendix code that does not correspond to the described method.

## 5. Self-score sheet

Score honestly before submission; below 70 means a weak paper, 85+ is competitive.

| Item | Max | Score | Evidence (file:line or section) |
|---|---|---|---|
| Every question answered with number + unit + uncertainty | 30 | | |
| Assumptions justified with a magnitude check | 20 | | |
| Validation against external data or limit case | 8 | | |
| Error budget / sensitivity with a dominant term | 7 | | |
| Structure maps onto the questions; summary answers | 15 | | |
| Figures: labelled, legible, each supporting a claim | 10 | | |
| Compliance: header, four items, ≤300 words, no names | 5 | | |
| References used in the body, consistent format | 5 | | |
| **Total** | **100** | | |

## 6. Ten-minute triage of someone else's draft

1. Read only page 1: do you know the answer to every question? (2 min)
2. Skim the section headings: do they map onto the questions? (1 min)
3. Find the validation: is there a number compared with an external number? (2 min)
4. Find the error budget: is there a table with a dominant term? (1 min)
5. Check five random numbers: units, significant figures, consistency with the summary. (2 min)
6. Check the figures: axes, legends, greyscale legibility. (2 min)

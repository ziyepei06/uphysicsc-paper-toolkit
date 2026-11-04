# Submission Checklist

Run top to bottom. Anything unchecked is a defect; anything you cannot check, say so explicitly.

## A. Compliance (rules — a violation costs points regardless of physics)

- [ ] Team number in the header of **every** page
- [ ] Page 1 contains only: team number, problem letter, title, Summary
- [ ] Summary ≤300 words, and it states approach + assumptions + answers with numbers + conclusion
- [ ] No name, school, city, or identifying mark anywhere (search the PDF for your name)
- [ ] Body restates the problem, states all assumptions, justifies each step
- [ ] Strengths and weaknesses section present
- [ ] References with in-text citations
- [ ] If generative AI was used: `\aiusedtrue` set in `config.tex`, and the last section is "Report on the Use of AI" with the systems table, verbatim prompts and full outputs
- [ ] If generative AI was not used: no AI paragraph anywhere, and no stray "Report on the Use of AI" heading in the PDF
- [ ] Filename `<team><problem>.pdf` (e.g. `778A.pdf`)

## B. Answers

- [ ] Every sub-question has its own subsection
- [ ] Every answer has a number, a unit and an uncertainty (or a stated range)
- [ ] Parameter sweeps cover the range the question implies, not one point
- [ ] The summary numbers equal the body numbers equal the conclusion numbers
- [ ] At least one explicit limiting-case check (e.g. `d→0`, `m→0`)

## C. Model and assumptions

- [ ] Each assumption carries a justification or an order-of-magnitude check
- [ ] Governing equations are derived or motivated, not dropped in
- [ ] Dimensional consistency checked at least once in the text
- [ ] Notation table present if more than ~8 symbols
- [ ] Every symbol defined at first use; no two symbols for one quantity

## D. Validation and error

- [ ] Comparison with external data, published value, or independent simulation
- [ ] Discrepancy quantified (relative deviation / RMSE), not just "good agreement"
- [ ] Error budget table with a dominant term
- [ ] Sensitivity analysis: at least one parameter varied ±10–20%
- [ ] Numerical convergence mentioned (step halving, mesh, tolerance)

## E. Figures and tables

- [ ] Both axes labelled with quantity and unit
- [ ] Text in figures ≥9 pt after scaling
- [ ] Greyscale-legible (colour + line style + marker)
- [ ] Uncertainties visible or explained
- [ ] Captions: figure captions below, table captions above, one sentence each
- [ ] Every figure and table referenced in the text
- [ ] No screenshot or Excel export pasted in

## F. References

- [ ] 8–12 sources, actually cited in the body
- [ ] Consistent format (`unsrt` or the template's `thebibliography`)
- [ ] Every entry resolvable (open every DOI/URL once)
- [ ] No AI-hallucinated references (check author, year, journal)

## G. Build

- [ ] `scripts/build.sh` exits 0
- [ ] No `??` undefined references or citations in the log
- [ ] No `File ... not found` warnings
- [ ] Overfull boxes reviewed (only cosmetic ones left)
- [ ] Fonts embedded (no Type 3)

## H. PDF check

- [ ] `python3 scripts/check_pdf.py paper.pdf 778 A` passes
- [ ] Page 1 readable in isolation: answer visible
- [ ] No blank pages
- [ ] Page numbers continuous from 1
- [ ] Text selectable (not scanned images)

## I. Delivery

- [ ] Filename correct: `<team><problem>.pdf`
- [ ] Sent at least 30 minutes before the deadline
- [ ] Confirmation of receipt kept (screenshot or email)
- [ ] Source files (`main.tex`, `figures/`, `code/`) archived in case of a resend request

## Quick triage if short on time

1. Summary ≤300 words and answers the question.
2. Every page has the team number.
3. No names anywhere.
4. Every sub-question has a number with a unit.
5. `check_pdf.py` passes.

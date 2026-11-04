---
name: upc-paper
description: Write, typeset, compile and QA a University Physics Competition (UPC) paper. Encodes the official contest rules plus empirical layout conventions measured from all 74 Gold Medal papers (2010-2025), a ready-to-compile LaTeX template, figure/table/number standards, a 48-hour plan, and automated compliance checks. Use whenever drafting, formatting, compiling, or reviewing a UPC (or MCM/ICM-style 48-hour physics) paper.
---

# UPC Paper Skill

A shared standard for every agent and human on the team: how to structure, write, typeset, compile and check a University Physics Competition paper. Every number in this skill was measured from the 74 Gold Medal papers on uphysicsc.com (2010–2025, 1,836 pages); every hard constraint comes from the official Contest Rules.

## Quick start

```bash
# 1. scaffold a full multi-file project (creates ./204B/)
bash scripts/new_paper.sh 204 B "Evacuation from a Breached Station"

# 2. write: config.tex holds identity, sections/*.tex hold the body,
#    figures/ holds vector PDFs, code/ holds what the appendix quotes

# 3. compile + compliance checks (fails loudly on undefined refs, missing figures)
cd 204B && make

# 4. submission-named PDF (<team><letter>.pdf) after the checks pass
make pdf
```

## What is in this skill

| File | Use it when |
|---|---|
| `references/official-rules.md` | You need the exact rule text: title page, summary, citations, AI disclosure, filename |
| `references/layout-conventions.md` | Deciding page count, columns, section skeleton, figure/table/reference budget |
| `references/writing-patterns.md` | Writing any section: purpose, required content, model sentences, failure modes |
| `references/latex-cookbook.md` | You need a compilable snippet: units, equations, tables, figures, code, multi-file setup |
| `references/figures-guide.md` | Making publication-quality figures and tables (matplotlib recipes included) |
| `references/numbers-and-units.md` | Reporting numbers: significant figures, uncertainty propagation, error budget, validation metrics |
| `references/timeline-and-roles.md` | Planning the 48 hours; dividing work across people or agents; handoff protocol |
| `references/judging.md` | Understanding what judges reward and what silently loses points |
| `references/exemplars.md` | Choosing which Gold Medal paper to read for a specific problem |
| `references/exemplar-profiles.md` | Per-paper structural profile of all 74 papers (pages, sections, figures, refs) |
| `checklists/submission-checklist.md` | Final pass before emailing the PDF |
| `templates/project/` | Starting a real paper: multi-file project with worked example, `Makefile`, all sections scaffolded |
| `templates/upc-paper.tex` | Minimal single-file skeleton, for a quick draft or a one-page test |
| `scripts/build.sh` | Compiling with a log gate |
| `scripts/check_pdf.py` | Automated compliance/rendering check |
| `scripts/count_summary.py` | Counting the summary against the 300-word limit |
| `scripts/new_paper.sh` | Scaffolding a multi-file paper directory |

## Non-negotiables (from the official rules)

1. **English**, formal paper.
2. **Page 1 contains only four items**: team number, problem letter (A or B), title, summary.
3. **Team number appears at the top of every page.**
4. **No names, institution, sponsor, or any identifying information** anywhere — including PDF metadata, acknowledgements, footers.
5. **Summary ≤ 300 words**, and it must state the work done, the model assumptions, the answers to the questions, the final numbers and the conclusions.
6. **A reference list and in-text citations** are both required. Never invent a reference.
7. **Numbers carry units and sensible significant figures; every graph has labelled axes.**
8. **If generative AI was used**, the paper must end with a section "Report on the Use of AI" listing the system, the verbatim query, and the full output.
9. **Filename is `<team><problem>.pdf`** (e.g. `778A.pdf`).

## Working defaults

- Target **20–28 pages**, **10–20 figures**, **8–12 references**, **~250-word summary** (all medians of Gold Medal papers: 23 pages, 14 figures, 8 refs, 240 words).
- Single column, 12 pt serif, Letter or A4, 1-inch margins — start from `templates/project/` and do not rebuild the preamble.
- Section skeleton: Introduction → Problem Restatement → Assumptions and Notations → Model → Method → Results → Discussion → Strengths and Weaknesses → Conclusion → References → Appendix.
- One figure per claim; one table for assumptions or parameters; number every equation you refer to twice.
- Every assumption gets a justification and a quantitative validity check.
- Every key number gets an uncertainty or a range.
- Write the summary last, then re-check that the conclusion repeats exactly the same numbers.

## Division of labour (agents or humans)

| Role | Owns | Never touches |
|---|---|---|
| Lead | plan, merging, final QA, submission | section prose |
| Modeler | assumptions, equations, analytics | LaTeX, figures |
| Coder | numerics, parameter sweeps, `results/*.csv` | interpretation |
| Figure | all figures/tables and captions | conclusions |
| Writer | `sections/*.tex`, summary, references | raw numbers |
| QA | compliance, compilation, number consistency | the model |

One owner per file. Only the Lead edits `main.tex`. Recompile after every merge; never keep writing on top of a red build.

## Definition of done

`check_pdf.py` exits 0, `checklists/submission-checklist.md` is fully ticked, the PDF is named `<team><problem>.pdf`, and the file has been emailed at least 30 minutes before the 48-hour deadline.

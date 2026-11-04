# The 48-Hour Plan and Team Roles

UPC is a hard 48-hour deadline. Below: an hour-by-hour plan, role split, handoff protocol and gates. Works for human teams and for agent teams (one context per role).

## 1. Timeline (T = contest start)

| Window | Goal | Output | Gate |
|---|---|---|---|
| T+0–2 | Read, choose A or B, list the questions | `notes/problem.md`: quantities, criteria, implicit conditions | Whole team agrees on what is asked |
| T+2–6 | Model v1 (zeroth order, analytic), order-of-magnitude answers | `notes/model-v1.md` + hand calculations | Every question has an order-of-magnitude answer |
| T+6–12 | Literature/data search, parameter values | `notes/params.md` (value + source), first `refs.bib` | Every key parameter has a provenance |
| T+12–20 | Numerics v1, main case running | `code/` + `results/run01.csv` | Main result reproducible with one command |
| T+20–26 | Figures v1, section skeletons | `figures/` + `sections/*.tex` skeletons | Every section has a heading and bullet points |
| T+26–34 | Full draft v1 | Compilable PDF (≥15 pages) | Builds clean; figure numbering continuous |
| T+34–38 | Validation, sensitivity, error budget | `results/` + Discussion drafted | At least one external validation |
| T+38–42 | Summary final (≤300 words), conclusion aligned | Page 1 + Conclusion | Summary/conclusion/body numbers identical |
| T+42–45 | Language pass, figure polish, layout | Candidate PDF | No overfull boxes, no undefined references |
| T+45–47 | Final checklist | Final PDF | `check_pdf.py` passes |
| T+47–48 | Name `<team><problem>.pdf`, email, keep buffer | Submission receipt | Sent ≥30 minutes early |

**T+34 is the watershed**: after it, no new modelling — only validation, writing and polish. If you want to add something, first decide what to delete.

## 2. Roles (agent contexts follow this split)

| Role | Owns | Does not own | Key deliverable |
|---|---|---|---|
| Lead | problem choice, decomposition, schedule, merging, final QA, single decision-maker | section prose | `plan.md`, final PDF |
| Modeler | assumptions, equations, analytic solutions, order-of-magnitude estimates | figures, LaTeX | `notes/model.md` (equations + notation) |
| Coder | numerics, sweeps, convergence, result CSVs | interpretation | `code/`, `results/*.csv`, `notes/method.md` |
| Figure | all figures and tables, caption drafts | conclusions | `figures/*.pdf`, `figures/README.md` (one line per figure) |
| Writer | section prose, summary, references | invented numbers | `sections/*.tex` |
| QA | compliance, build, number consistency, language | the model | `qa/report.md`, defect list |

Small teams (≤3 people) merge Modeler+Coder and Writer+QA — but **the final check must be done by someone who did not write that section**.

## 3. File conventions

```
paper/
├── main.tex
├── sections/01-intro.tex … 09-conclusion.tex
├── figures/            # final PDFs only; source scripts in scripts/
├── code/               # code referenced by the appendix
├── results/            # CSV/JSON that the figures are built from
├── notes/              # modelling notes, parameters, question list (not in the paper)
├── refs.bib
└── qa/                 # check reports
```

Names: `fig_<section>_<content>.pdf` (`fig_6_pressure_vs_time.pdf`); results `run<two digits>_<description>.csv`.

## 4. Handoff protocol (four items, always)

1. **What was done** — one sentence plus file paths.
2. **Key numbers** — with units and uncertainty.
3. **Known problems** — what is unfinished or unreliable.
4. **Next step** — a concrete suggestion for the receiver.

Example:

> Main model solved. `results/run03.csv`: $t_{0.3}(d{=}1\text{cm})=38.1$ s, step-halving change 0.02%. Known issue: $C_d$ is fixed at 0.82 (literature 0.6–1.0), sensitivity not done. Next: Figure to plot $t$–$d$, Writer to draft 6.1.

A handoff without item 3 is not a handoff.

## 5. Parallel work and conflicts

- One owner per section, no overlap in `sections/`; only the Lead edits `main.tex`.
- Shared macros (symbols, unit commands) live only in `main.tex`; announce before changing them.
- Figure numbering is automatic — never write "Figure 3" by hand, always `\ref{}`.
- Rebuild after every merge; if the build is red, revert rather than pile on more edits.
- Never let two agents write the same file; to change someone else's section, message them with the exact lines.

## 6. Gates

| Gate | Time | Pass condition |
|---|---|---|
| G1 Problem | T+2 | One sentence per problem: what is asked, what the criterion is |
| G2 Magnitude | T+6 | Every question has an order-of-magnitude answer within one decade |
| G3 Reproducible | T+20 | A newcomer reproduces the main result with one command from the README |
| G4 Skeleton | T+26 | Compiles; section headings map one-to-one onto the questions |
| G5 Draft | T+34 | Every section has substance; no TODOs |
| G6 Validation | T+38 | External comparison + sensitivity + error budget complete |
| G7 Compliance | T+45 | Page-1 four items, team number on every page, summary ≤300 words |
| G8 Delivery | T+47 | `check_pdf.py` passes, filename correct, email sent |

## 7. Final six hours (from T+42)

1. Rewrite the summary once (write, then cut to 300 words).
2. Align the conclusion numbers with the summary.
3. Re-export every figure with uniform fonts, widths and palette.
4. Walk through `checklists/submission-checklist.md`.
5. Have someone read **only page 1** and ask: "Do you know what our answer is?" If not, fix the summary.
6. Send a test email to yourself and confirm the attachment opens.

## 8. Agent-specific notes

- Context is finite: hand over conclusions, numbers and paths, not the whole transcript.
- Never let two agents edit the same `.tex`; keep an ownership table.
- `results/*.csv` is the source of truth — every number in the prose must be traceable to a CSV.
- Any AI-generated reference must be verified to exist (open the DOI/URL) before it enters `refs.bib`.
- Log every AI use (system, query, output) as you go; it becomes the "Report on the Use of AI".

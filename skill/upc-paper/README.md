# upc-paper — a shared skill for UPC teams

A single, self-contained skill that teaches an agent (or a person) how to write, typeset, compile and check a University Physics Competition paper. It encodes

- the **official contest rules**, quoted with the action each one implies;
- **measured conventions** from all 74 Gold Medal papers published on uphysicsc.com, 2010–2025 (1,836 pages): page counts, section skeletons, figure/table/reference budgets, summary length;
- a **compilable LaTeX template** that already satisfies the rules;
- **scripts** that build with a log gate, check the PDF for compliance, and count the summary;
- **reference chapters** on writing, figures, numbers, LaTeX, judging and the 48-hour schedule.

## Using it

Nothing to install by hand. The skill is a directory of Markdown files, a
LaTeX template and three scripts; hand it to your agent — as a folder, or as
`upc-paper-skill.zip` from the release — and say "set this up and use it for
our paper". The agent reads `SKILL.md`, puts the folder wherever its runtime
loads skills from, and works from there.

The entry point is `SKILL.md`: frontmatter gives the name and the trigger
description, the body gives the quick start, the file map and the
non-negotiables.

### Without an agent

Read `SKILL.md`, then work through `references/` in this order:
`official-rules.md` → `layout-conventions.md` → `writing-patterns.md` →
`latex-cookbook.md` → `figures-guide.md` → `numbers-and-units.md` →
`timeline-and-roles.md` → `judging.md`, with `exemplars.md` open in a second
window.

## What the scripts need

- `latexmk` and `pdflatex` from any TeX distribution, with `booktabs`,
  `siunitx`, `caption`, `listings`, `tocloft`.
- Python 3.9+ with PyMuPDF for the PDF checks; the checker prints the one
  import that failed and nothing else is fetched at run time.
- Optional: matplotlib for the example figure.

## Use in one minute

```bash
cd /path/to/upc-paper          # wherever the skill lives
bash scripts/new_paper.sh 204 B "Evacuation from a Breached Station"   # creates ./204B/
cd 204B && make                                                        # compile + checks
make pdf                                                               # 204B.pdf
```

`new_paper.sh` copies the whole multi-file project (sections, preamble, `refs.bib`, `code/`, `scripts/`, `Makefile`, `notes/`), fills the team number, problem letter and title into `config.tex`, and records the skill path in `local.mk` so `make` works from any directory. `build.sh` stops on the first LaTeX error and fails if a reference or a figure is undefined. `check_pdf.py` enforces the rule-level checks (four items on page 1, ≤300-word summary, team number on every page, references, filename) and warns about length, figure count, missing fonts and identifier leakage.

## What is inside

```
upc-paper/
├── SKILL.md                        entry point: rules, quick start, file map
├── README.md                       this file
├── templates/
│   ├── project/                    full multi-file paper, compiles as-is (11 pages)
│   │   ├── main.tex, config.tex, preamble.tex, refs.bib, Makefile
│   │   ├── sections/00–11          every section scaffolded, with %% GUIDE comments
│   │   ├── code/blowdown.py        the model quoted in the appendix
│   │   ├── scripts/make_example_fig.py   regenerates figures/example.pdf
│   │   └── notes/                  scratch space, not compiled
│   ├── upc-paper.tex               minimal single-file skeleton (4 pages)
│   └── figures/example.pdf         matplotlib example, Okabe–Ito palette
├── scripts/
│   ├── build.sh                    latexmk + log gate (undefined refs, missing files, overfull)
│   ├── check_pdf.py                rule compliance + rendering + anonymity checks
│   ├── count_summary.py            summary word count, from .tex or .pdf
│   └── new_paper.sh                scaffold a paper directory
├── references/
│   ├── official-rules.md           rule text → required action
│   ├── layout-conventions.md       measured statistics + section skeleton
│   ├── writing-patterns.md         section-by-section writing guide
│   ├── latex-cookbook.md           compilable snippets for every construct
│   ├── figures-guide.md            figure/table standards + matplotlib recipes
│   ├── numbers-and-units.md        significant figures, uncertainty, error budget
│   ├── timeline-and-roles.md       48-hour plan, roles, handoffs, gates
│   ├── judging.md                  scoring model and self-score sheet
│   ├── exemplars.md                8 close reads + lookup table + full index
│   └── exemplar-profiles.md        structural profile of all 74 papers
└── checklists/
    └── submission-checklist.md     final pass, section by section
```

## Design decisions

- **Rules first, taste second.** Anything the contest rules require is a hard check in `check_pdf.py`; anything derived from the corpus is presented as a default that can be overridden with a reason.
- **Measured, not guessed.** The numbers in `layout-conventions.md` come from a PyMuPDF pass over the 74 PDFs (page counts, text blocks, font spans, caption patterns, bracket-reference counts). Where a measurement is approximate, the file says so.
- **The template is the standard.** Teams should not rebuild the preamble; they edit content and `\teamnum`, `\problemltr`, `\papertitle`. This keeps 74-paper-consistent typography across a team and makes merged PDFs look uniform.
- **Scripts fail loudly.** A build that silently ships `??` references is worse than a build that stops.
- **Agent-agnostic.** Markdown only, no runtime-specific syntax; the same files work for humans.

## Adapting it

- Different contest (MCM/ICM, a national olympiad): copy the directory, rewrite `references/official-rules.md`, and adjust the thresholds in `check_pdf.py` (`--max-summary`, page-count warnings).
- Two-column layout: the template has a commented `twocolumn` note; the statistics show 18 of 74 Gold papers use two columns, so either is defensible.
- More chapters: keep the one-concern-per-file structure and add the file to the table in `SKILL.md`.

## Provenance

- Rules: <https://www.uphysicsc.com/contestrules.html> (retrieved 2025).
- Papers: 74 Gold Medal PDFs from the yearly pages `uphysicsc.com/<year>contest.html`, stored under the parent directory in `2010/` … `2025/`.
- Statistics and tables in `references/` were generated by scripts in this repository's history; the raw per-paper data is reproducible with PyMuPDF from the PDFs themselves.

# What the 74 Gold Medal Papers Actually Look Like

Sample: every Gold Medal paper published on uphysicsc.com, 2010–2025 (no papers were published for 2024). 74 papers, 1,836 pages. Statistics extracted with PyMuPDF (page counts, text blocks, font spans, caption patterns, bracket-reference counts).

## 1. Size

| Metric | Min | p25 | Median | p75 | Max |
|---|---|---|---|---|---|
| Pages | 5 | 17 | **23** | 28 | 111 |
| Figures (counted by "Figure n") | 0 | 8 | **14** | 20 | 36 |
| Tables (counted by "Table n") | 0 | 0 | **1** | 4 | 18 |
| Reference entries | 0 | 4 | **8** | 11 | 32 |
| Summary words | 101 | 213 | **240** | 279 | 373 |

Distribution: 10 papers ≤15 pages, 50 papers 16–30 pages, 14 papers >30 pages. 51 of 74 have at least 10 figures.

Takeaway: **20–28 pages, 10–20 figures, 8–12 references** is the safe zone. Gold papers are figure-heavy and table-light; tables are reserved for assumptions, parameters and multi-case comparisons.

## 2. Page and type

- Paper size: A4 44 papers, Letter 29, near-A4 1 — both accepted. The template defaults to Letter; switch to `a4paper` for local printing.
- Columns: single column **56/74**, two columns 18/74 (the two-column papers mostly use a LaTeX conference style). Beginners should stay single-column.
- Body font: Computer Modern / Latin Modern (LaTeX default) and Times-like faces split roughly evenly; body size 10–12 pt, most often 11–12 pt.
- Page numbers: almost always bottom-centre; some papers put "Team 234 Page 3 / 28" in the header.

## 3. Section skeleton

Counted by keyword presence across the corpus:

| Element | Papers | Note |
|---|---|---|
| Introduction | 70/74 | near-universal |
| Model / Modelling | 70/74 | often split into sub-models |
| Results | 68/74 | one subsection per question asked |
| Analysis | 67/74 | frequently merged with Model |
| Method | 65/74 | numerics, algorithm |
| Conclusion | 64/74 | answers question by question |
| References | 62/74 | others say "Bibliography" or "Reference" |
| Appendix | 51/74 | code, long derivations |
| Discussion | 42/74 | merging with Conclusion is common |
| Assumptions (section or explicit block) | 66/74 | the signature Gold Medal move |
| Strengths / Weaknesses | 49/74 / 38/74 | required by the rules |
| Notations / Nomenclature | 30/74 | symbol table |
| Limitations | 25/74 | usually inside Discussion |

The cleanest skeleton in the corpus: `2020/2020-GM-A-354.pdf` — 1 Notations → 2 Introduction → 3 Theory → 4 Method → 5 Results (5.1–5.4) → 6 Discussion and Conclusion → 6.1 Limitations → 7 Appendix.

## 4. Title page

Shared features across all 74: team number, problem letter, title, summary — and nothing else decorative. Three common layouts:

- **Contents page.** 50 of the 74 gold papers (68 %) print a Contents page
  right after the summary sheet; it is not required, but it is normal for a
  20-page paper and cheap to produce. The template ships
  `\tableofcontents` with dot leaders and a two-level depth; delete the call
  if you prefer to go without.
- **Summary or Abstract?** The rule asks for "a summary ... which will be an
  abstract", so both labels are defensible. Practice leans to Abstract: 64 of
  the 74 gold papers print "Abstract", 5 print "Summary", 3 use both. The
  template ships "Abstract", the majority choice; change the word in
  `sections/00-frontmatter.tex` if the team prefers the rule's wording. The
  counting scripts accept either.
- Centred stack: `Team 234` / `Problem A` / title / Summary (`2023/2023-GM-A-131.pdf`)
- Top-left information block plus large title and Summary (MCM-style, `2022/2022-GM-A-395.pdf`)
- Header right "Team 699 Page 1 / 28", continuing on body pages (`2017/2017-GM-A-699.pdf`)

Several papers also print a date ("November 5, 2023"). The rules allow it, but a date is not one of the four items; the strict reading omits it, and the template does.

## 5. Equations

- Median 15 numbered equations per paper; equations referenced later are essentially always numbered, cited as `Eq. (3)`, `Eqs. (3)–(5)`.
- Symbols are defined at first use and kept consistent; 30 papers include an explicit Notations table.
- Units upright (`\si{m/s}`), vectors bold, differentials upright (`\mathrm{d}`), partials `\partial`.

## 6. Figures

- Captions below the figure, `Figure 12: ...`, stating what is plotted, under which conditions, and what it shows.
- Both axes carry a quantity and a unit: `$t$ (s)`, `$p/p_0$`; tick labels at 70–80% of body size.
- Mostly vector PDF/PS; scatter plots carry error bars or a sentence explaining why they are absent.
- Recurring figure types: trajectories/phase portraits, families of curves from parameter sweeps, residual/error plots, schematic diagrams, occasional 3-D illustrations.

## 7. Tables

- Mostly booktabs three-line tables; captions above the table.
- Typical uses: assumption lists (assumption / reason / check), notation tables, parameter values, multi-scheme comparisons, result summaries.
- Numbers aligned on the decimal point (`siunitx` `S` columns); no undefined symbols inside tables.

## 8. References

- 72/74 use bracketed numeric citations (`[1]`, `[2,3]`, `[4–6]`) with an ordered list; every in-text citation resolves.
- Median 8 entries, maximum 32; journal articles, textbooks, NASA/ESA technical reports, software documentation, web pages.
- Web entry pattern: Organisation, "Page title," URL, accessed YYYY-MM-DD.
- Journal entry pattern: A. Author, B. Author, "Title," *Journal* **vol**(issue), pages (year).

## 9. How the four mandatory blocks appear

1. Restatement of the problem → its own subsection right after the Introduction.
2. Assumptions → numbered A1, A2, … each with an order-of-magnitude validity check (e.g. Kn ≪ 1).
3. Justification → every model or approximation is followed by "why this is allowed, and how large the error is".
4. Strengths and weaknesses → a dedicated section with 3–5 specific items each, tied to model components rather than generic praise.

# Official Rules (extract)

Source: <http://uphysicsc.com/contestrules.html>, retrieved 2026-11-04. Quotations are verbatim; the notes translate them into concrete actions. Always defer to the current official page.

## 1. Submission and anonymity

> "All teams must prepare a formal paper, written in English, in which they explain their work."

> "The paper must list the team number at the top of each page, but the paper must not contain the names of the students, their institution, or any other identifying information."

> "The first page of the paper should contain only four items, (1) the team number, (2) the problem selected ("A" or "B"), (3) the title of the paper, and (4) a summary"

Actions: header with the team number on every page; no names/schools anywhere (including PDF metadata and acknowledgements); page 1 has exactly those four elements and nothing else (no date, no logo, no abstract heading decoration).

## 2. The summary

> "a summary, no longer than 300 words in length, which will be an abstract providing key details of the work performed, the assumptions of the models used, answers to the questions posed, final numbers, results and conclusions."

Actions: ≤300 words; must contain the assumptions, one answer per question, the final numbers, and the conclusion. Count it mechanically (`scripts/count_summary.py`).

## 3. Paper content

> "The body of the paper, which follows this first page, may be of any length necessary to report the team's work."

> "Each paper must include a list of references used, as well as make in-text citations to these resources."

> "Papers may use existing algorithms and computational tools ... as long as these are correctly referenced, cited, and the methods are clearly explained within the paper."

> "Numbers must be presented with appropriate significant figures and clearly indicated units. Graphs must have clearly labeled axes. All variables must be clearly defined and used consistently throughout the paper."

> "Any computer programs written may be included as an appendix to the paper, however all algorithms, methods and results must be explained in the main text of the paper to receive consideration during judging."

> "Each paper must include at minimum (1) a restatement and clarification of the problem as interpreted by the team, (2) an explanation of all assumptions and approximations made, (3) justification for all work performed, as well as (4) a discussion of the strengths and weaknesses of the approach taken."

Actions: four mandatory content blocks; citations in text and in the list; appendices never carry the method.

## 4. Generative AI

> "Teams are encouraged to write their papers without the use of generative AI tools ... AI tools have been found to hallucinate, to generate false content. AI tools have also been found to plagiarize ... Papers that contain plagiarism or false content will be severely penalized."

> "If a team uses a generative AI tool in writing the paper it is required that the team is transparent about this, clearly stating what tools were used and in what way. The end of the paper must contain a section "Report on the Use of AI" stating (1) what system was used, (2) the query (the exact wording input into the AI tool), and (3) the full output (a copy of the complete output from the AI tool.)"

Actions: keep a log of every prompt and output while working; set
`\aiusedtrue` in `config.tex` so the section compiles; verify every
AI-produced number and reference by hand.

Scale of the problem: of the 16 gold papers in 2025, four disclose AI use and
only one — 2025-B-765, appendix B — supplies the verbatim queries and the full
outputs; it spends five pages on them. Disclosure done properly is rare, which
makes a clean one an easy way to look more careful than the field.

## 5. Submission format

> "Papers may be submitted as pdf, doc, or docx files."

> "The filename of the paper should be the team number followed by the problem letter, for example 778A.pdf or 832B.doc."

Actions: submit PDF, named `<team><problem>.pdf`, emailed to solutions@uphysicsc.com before the 48-hour deadline.

## 6. Context: medal rates

Gold ≈ top 2%, silver 15–20%, bronze 25–30%, the rest "accomplished competitor". Gold Medal papers are the `YYYY-GM-A/B-team.pdf` files published on the site.

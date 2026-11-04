# Writing Guide: What Goes in Each Section

For every section: **purpose → required content → how to write it → model sentences → failure modes**. The model sentences are distilled from patterns used across the 74 Gold Medal papers; copy the structure, never the content.

## 0. The one thread: the argument chain

A judge reads a paper to answer four questions:

1. Did you understand the problem? (Restatement)
2. Why should the model be believed? (Assumptions + justification)
3. Where do the numbers come from, and how wrong are they? (Method + Results + uncertainty)
4. How does your approach compare with alternatives? (Strengths / Weaknesses / validation)

Every section must serve this chain. If deleting a section leaves all four answerable, delete or merge it.

---

## 1. Summary (page 1, ≤300 words, the most important paragraph)

### Four blocks, in order

| Block | Words | Content | Example |
|---|---|---|---|
| S1 Situation | 30–50 | The physical scenario and the goal, one sentence | "We model the blow-down of a pressurised station module through a hull breach and determine the time to reach a survivable pressure." |
| S2 Model | 60–90 | The model and 2–3 key assumptions | "The flow is treated as quasi-steady isentropic expansion of an ideal gas (A1–A3), choked while $p/p_0>0.528$." |
| S3 Results | 100–140 | **Answer each question with numbers and units** | "For a 1 cm hole the pressure falls to 0.3 atm in 38 s; doubling the hole halves the time to 19 s." |
| S4 Validation | 50–70 | What it was checked against, the error, one conclusion | "The model reproduces the published blow-down curve within 8%; the dominant uncertainty is the discharge coefficient, ±20%." |

### Hard requirements

- **≤300 words** (`scripts/count_summary.py`, and `check_pdf.py`, both enforce it).
- The final numbers must appear — a judge reading only the summary must learn your answers.
- No "the paper is organised as follows"; no equations; no citations.
- Tense consistent with the rest of the paper.

### Three openers you can reuse

- Problem-first: "Safe evacuation from a breached station depends on how fast the internal pressure falls."
- Method-first: "We combine a quasi-steady blow-down model with a two-zone thermal model to predict …"
- Result-first: "A 1 cm hull breach is survivable for 38 s without a pressure suit, but only if the crew reaches the airlock within 25 s."

### Failure modes

- A background essay with no answer — the single most damaging mistake.
- Numbers without units or significant figures ("about 40" instead of "38 s").
- Navigation sentences ("In Section 2 we …") wasting the word budget.
- Translationese: "This paper mainly studies …" → "We quantify …".

---

## 2. Introduction

### Required

1. Physical background: why the scenario matters (2–3 sentences, not a science-popularisation essay).
2. Prior work, **with citations** (3–6 references).
3. The gap: what existing approaches miss under the conditions of this problem (one sentence).
4. Contribution: what you did and the order of magnitude of the result (≤3 bullets).

### How to write it

- One topic sentence per paragraph; the first sentence must carry the paragraph.
- Cite specifically: "Kim et al. [4] assumed isothermal walls, which overestimates the blow-down time by 15% below 0.5 atm" beats "Many studies have investigated this [4–9]."
- Close with a one-sentence roadmap, not a paragraph.

### Model paragraph

> A hull breach in a space station vents the internal atmosphere in seconds to minutes, and the resulting pressure history decides whether the crew can reach shelter in time. Analytical blow-down models date back to the 1960s [1], and modern treatments add wall heat transfer [2] and real-gas effects at high pressure [3]. These models, however, fix the discharge coefficient and do not resolve the choked-to-subsonic transition, which dominates the last 30% of the evacuation. In this paper we (i) derive a choked-to-subsonic blow-down model, (ii) calibrate it against the published ISS leak test [4], and (iii) give a closed-form estimate of the time to reach 0.3 atm.

### Failure modes

- Encyclopedia background (what cosmic radiation is, how big Mars is).
- A list of references with no evaluation — the reader cannot see where you stand.
- No roadmap, or a roadmap that takes half a page.

---

## 3. Problem Restatement and Clarification

### Required

- Restate the problem in your own words (do not copy the prompt).
- List the quantities asked for: symbol, unit, and the criterion ("safe" defined quantitatively).
- Name ambiguities and state your interpretation ("we read 'habitable' as $p>0.3$ atm and $T\in[10,30]^\circ$C").
- Give the solution route: what is computed first, what depends on what, where the difficulty is.

### Model text

> The problem asks for (i) the time $t_{0.3}$ for the internal pressure to fall from $p_0=1$ atm to $0.3$ atm after a hole of diameter $d$ opens, and (ii) the largest $d$ for which $t_{0.3}>60$ s. We take "survivable" to mean $p\ge0.3$ atm and $T\ge10^\circ$C, and we allow the crew 20 s to don masks, so the effective requirement is $t_{0.3}>80$ s.

### Failure modes

- Smuggling assumptions into the restatement (they belong in the next section).
- No criterion, so later results cannot be judged as sufficient or not.

---

## 4. Assumptions and Notations

### Each assumption: number + statement + reason + check

`A1 | statement | why it is allowed | order-of-magnitude check or error estimate`

Table form (recommended):

| # | Assumption | Justification | Validity check |
|---|---|---|---|
| A1 | Air behaves as an ideal gas | $p<10$ atm, $T\in[250,350]$ K, $Z-1<2\%$ | $Z=0.998$ at 5 atm |
| A2 | Quasi-steady outflow | hole diameter ≪ module length | $d/L=0.01$ |
| A3 | Adiabatic walls for the first 60 s | thermal diffusion time ≫ 60 s | $\tau=L^2/\alpha\approx40$ min |

**An assumption without a check is not an assumption, it is an assertion.** When a check is impossible, state which way the result would move and by how much.

### Notation table

- Ordered Latin → Greek → sub/superscript conventions; three columns: symbol, meaning, unit (or dimensionless).
- Define each symbol exactly once; never reuse a symbol with two meanings.
- Common conventions: $p$ pressure, $T$ temperature, $\rho$ density, $u$ velocity, $A$ area, $V$ volume, $\gamma$ heat-capacity ratio, $C_d$ discharge coefficient.

### Failure modes

- "We assume the air is an ideal gas" with no reason.
- Twenty micro-assumptions, including things that could be derived.
- Notation table inconsistent with the body ($v$ in text, $u$ in the table).

---

## 5. Model / Theory

### Layered modelling (the dominant Gold Medal pattern)

Start simple, add physics in layers:

1. **Baseline**: zeroth-order model, analytically solvable, gives the order of magnitude.
2. **Refinement 1**: add the main correction (drag, heat transfer, non-ideal gas) and say how much the answer moved.
3. **Refinement 2**: add the secondary correction, or solve numerically.
4. **Final model**: state which one you use and why.

For each layer answer: what was added, why it is needed, how much the result changed.

### Equation discipline

- Number important equations; derivations cited once may go to the appendix.
- A sentence before ("mass conservation gives") and after (physical meaning of each term).
- Non-dimensionalise when possible: reduce to 2–3 dimensionless groups (Reynolds, Knudsen, Froude) and the discussion writes itself.
- Put the dimensional check in the text: "both sides carry units of Pa/s".

### Model text

> Mass conservation for the module gives
> $$\frac{\dd p}{\dd t}=-\frac{\gamma p A}{V}u(p), \tag{1}$$
> where $u(p)$ is the exit speed from Eq. (2). The factor $\gamma p/V$ is the isentropic bulk modulus; both sides of Eq. (1) carry units of Pa/s.

### Failure modes

- A complicated equation with no motivation.
- A textbook chapter (re-deriving the ideal-gas law).
- Several models with no comparison, so the reader cannot tell which one produced the results.

---

## 6. Method / Numerical Solution

### Required

- Algorithm name and source (cite it), or the steps of your own algorithm (numbered).
- Parameter table with values and provenance (literature / fit / assumption).
- Discretisation: step size, grid, boundary conditions.
- Convergence: halving the step changes the answer by how much; Monte Carlo sample count; optimiser iterations and sensitivity to the initial guess.
- Environment and reproducibility: software, version, code location (appendix).

### Model text

> We integrate Eq. (1) with a fourth-order Runge–Kutta scheme ($\Delta t=10^{-3}$ s); halving $\Delta t$ changes $t_{0.3}$ by 0.02%. The discharge coefficient is calibrated once against the ISS test [4] and then held fixed.

### Failure modes

- "We used MATLAB" and nothing else.
- No convergence statement — the numbers are then unverifiable.
- Code only in the appendix, method missing from the body (an explicit rule violation).

---

## 7. Results

### Organisation: one subsection per question

Each subsection has four fixed parts:

1. **Answer sentence**: the number ("$t_{0.3}=38$ s for $d=1$ cm").
2. **Supporting figure or table**: one figure for the trend, or one table for several cases.
3. **Uncertainty**: $\pm3$ s, dominated by $C_d$.
4. **Interpretation**: one sentence of physical intuition ("time scales as $d^{-2}$ because mass flux scales as $d^2$").

### Number presentation

- Uncertainty to 1–2 significant figures, result aligned: $38\pm3$ s, not $38.27\pm3.1$ s.
- SI units; engineering units allowed but labelled; never mix unit systems silently.
- Large numbers in scientific notation: $1.2\times10^{4}$ m.

### Failure modes

- A figure with no number, or a number with no figure.
- New assumptions appearing in Results.
- A figure with ten lines the text never disambiguates.

---

## 8. Discussion / Validation

### Three things

1. **External validation**: compare with experiment, literature, or a known limit; give the percentage deviation.
2. **Sensitivity**: change the least certain parameter by ±20%, report how much the answer moves.
3. **Error budget**: a table of sources and magnitudes, naming the dominant term.

### Model text

> The model reproduces the measured blow-down curve of [4] within 8% over $1>p/p_0>0.35$. A ±20% change in $C_d$ shifts $t_{0.3}$ by ±19%, while ±10 K in wall temperature shifts it by 2%; the discharge coefficient therefore dominates the error budget (Table 5).

### Cheap wins: limit checks

- $d\to0$: $t\to\infty$, as expected.
- $\gamma\to1$: reduces to the isothermal solution of [2].
- Order-of-magnitude comparison with dimensional analysis: $t\sim V/(A c_s)$.

### Failure modes

- "Errors come from model simplification and parameter uncertainty" — with no numbers this says nothing.
- Comparing only against your own second model (self-validation).

---

## 9. Strengths and Weaknesses

### Write 3–5 specific items each, tied to model components

Strengths:
- The model matches experiment within X% over the range that matters.
- Assumption A2 was checked to contribute <Z% error.
- A closed-form scaling law $t\propto d^{-2}$ extrapolates beyond the problem's parameters.
- The method is reproducible: parameters, code and convergence all reported.

Weaknesses:
- Choked flow is assumed throughout; below $p/p_0=0.528$ this overestimates the mass flux by ~12%.
- Wall heat conduction is neglected, which underestimates the late-time pressure.
- A one-dimensional model cannot resolve the near-hole two-dimensional flow.

### Forbidden

- "Our model has errors but is overall good."
- "We ran out of time and did not do experiments." (Judges do not care about your schedule.)
- Listing a weakness without its magnitude.

---

## 10. Conclusion

### Structure

1. Answer question by question: `(i) …; (ii) …; (iii) …`, each with the final number.
2. One sentence on the method and how well it was validated.
3. One sentence on generalisation or limitation (optional).

### Model text

> (i) A 1 cm breach drops the pressure to 0.3 atm in 38 s; (ii) the largest survivable hole is 1.6 cm, giving 80 s; (iii) the time scales as $d^{-2}$ and is insensitive to wall temperature. The model agrees with the ISS leak test within 8%, with the discharge coefficient as the dominant uncertainty.

### Failure modes

- New results appearing for the first time in the conclusion.
- "We built a model and obtained reasonable results" — no answer to the problem.
- Numbers inconsistent with the summary after a late edit.

---

## 11. References

- Bracketed numeric, ordered by first citation; `[1]`, `[2,3]`, `[4–6]`.
- Every entry needs authors, title, source, year; web pages need an access date.
- Cite only what you have actually read. **Never fabricate** — the rules penalise this severely.
- 8–12 entries is the sweet spot: 1–2 textbooks, 4–6 papers/reports, 2–3 data/software sources.

```
[1] A. B. Author, C. D. Author, "Title of paper," Journal Name 12(3), 45–67 (2020).
[2] E. F. Author, Book Title, 2nd ed. (Publisher, City, 2019), ch. 4.
[3] NASA, "ISS leak test report," https://example.org/report, accessed 2026-11-04.
```

---

## 12. Appendix

- Put here: full derivations, code, supplementary parameter tables, extra figures.
- Never put here: methods or results that the body does not explain (explicit rule).
- Code appendix: language, dependencies, how to run; comment the key functions.
- Label A, B, C and refer to "Appendix A".

---

## 13. Report on the Use of AI (only if AI was used)

The rule is literal: name the system, quote the query verbatim, reproduce the
output in full. Four of the 16 gold papers in 2025 did this; only one
(2025-B-765) satisfied all three clauses, and it spent five pages on it. So
the section is short in structure and long in evidence — that is the trade.

**If no generative tool touched the paper, write nothing.** No "no AI was
used" paragraph: silence is the correct state, and the template enforces it
(the section compiles only when `\aiusedtrue` is set in `config.tex`).

Ordered the way the rule reads:

1. **Systems table** — system name, developer, version and date of access,
   interface (web chat / API / IDE plug-in), and what it was used for.
   List every assistant that received team text, code or data.
2. **Work carried out without AI** — the model, the derivation, the numerical
   scheme, the parameter choice, the figures, the conclusions. Say which of
   them the assistant never touched. Do not overclaim: if it proposed an
   equation that survived, the query belongs in the table below even if you
   re-derived it.
3. **Queries table plus verbatim prompts** — number them; the opening words
   go in the table, the full wording in a `lstlisting` block beneath it.
   Keep typos: the rule asks for the exact wording, not a cleaned-up version.
4. **Outputs in full, one block per query** — same numbering, unedited,
   mistakes included. Say "including its mistakes" if it made any; graders
   check the report against the paper.

Practical notes:

- Budget the pages. Five pages of raw output is normal when code was
  generated; language-only use needs a page or less.
- Log as you go (see `timeline-and-roles.md`): reconstructing a week of
  prompts from memory on the last night produces a report that does not
  match the chat history.
- Keep the log honest but small: do not ask an assistant for work you can do
  yourself, and you will have little to disclose.
- The section belongs at the very end, after the appendices. In the template
  it is appendix D (letters follow the appendix count), heading
  "Report on the Use of AI" exactly as the rule spells it.

---

## 14. Paragraphs and sentences

- One claim per paragraph, topic sentence first, 4–8 sentences.
- Prefer active voice: "We integrate Eq. (1)", not "Equation (1) is integrated".
- A number sentence carries three things: value, unit, condition ("38 s at $d=1$ cm").
- Avoid: very, quite, obviously, it is well known that.
- Tense: past or present for method and results, but consistent; present for general facts.
- Connectors sparingly: at most two of however / therefore / in contrast per paragraph.

## 15. Section-by-section self-check

- [ ] Summary ≤300 words with the final numbers
- [ ] Introduction has citations, a gap, and a contribution
- [ ] Restatement defines the criterion
- [ ] Every assumption has a reason and a check
- [ ] Every model layer says what was added and how much the answer moved
- [ ] Method reports parameters, convergence, software
- [ ] Results answer each question with value, unit, uncertainty
- [ ] At least one external validation or limit check
- [ ] Strengths and weaknesses are specific, ≥3 each
- [ ] Conclusion answers question by question and matches the summary
- [ ] ≥8 references, all cited in text
- [ ] Appendix carries no essential method

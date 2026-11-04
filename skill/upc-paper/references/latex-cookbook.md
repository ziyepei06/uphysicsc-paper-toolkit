# LaTeX Cookbook

All snippets assume the preamble of `templates/upc-paper.tex`. Copy, then replace the placeholders.

## 1. Minimal preamble

```latex
\documentclass[12pt,letterpaper]{article}
\usepackage[letterpaper,margin=1in]{geometry}
\usepackage[T1]{fontenc}\usepackage[utf8]{inputenc}\usepackage{lmodern}
\usepackage{amsmath,amssymb,bm}
\usepackage{siunitx}
\sisetup{detect-all,per-mode=symbol,exponent-product=\times}
\usepackage{graphicx,booktabs,multirow,array,float}
\usepackage[font=small,labelfont=bf]{caption}\usepackage{subcaption}
\usepackage{enumitem,listings,xcolor}
\usepackage[colorlinks=true,linkcolor=blue!50!black,citecolor=blue!50!black,urlcolor=blue!50!black]{hyperref}
\usepackage{fancyhdr}
```

Order matters: `hyperref` goes last (with a few exceptions such as `cleveref`, which must come after it).

## 2. Units and numbers (siunitx)

```latex
\SI{9.81}{m/s^2}              % 9.81 m/s²
\SI{1.2e4}{m}                 % 1.2×10⁴ m
\SI{38 \pm 3}{s}              % 38 ± 3 s
\si{kg.m/s^2}                 % unit only
\num{3.1416}                  % number, locale-aware
\ang{30}                      % 30°
```

Never hand-write `$9.81\,m/s^2$` — the italic *m* is wrong for a unit. Use `S` columns to align decimals in tables.

For units written by hand (a notation table, an axis label), `^{-1}` is wrong
twice over: the math minus keeps its full advance, so it reads as a long dash
floating away from the digit, and at 73 % script size it dwarfs the unit letter.
The preamble defines `\inv` for this:

```latex
m\,s\inv        % m s⁻¹, short minus, script size
kg\inv\,K\inv   % good
m\,s$^{-1}$     % avoid: long minus, loose spacing
```

`\inv` is `\textsuperscript{\scalebox{0.65}[1]{$-$}1}`: the minus is squeezed
horizontally to 65 %, kept on the script axis, and set at the script size so it
sits comfortably next to the digit. It still typesets a real minus character, so
the PDF stays searchable and copy-pasteable (`$`-based rules would not). Use it
for every unit exponent of minus one; leave real exponents such as `10^{-4}`
alone.

Products of units are separated by a thin space, never written solid: `ms`
is a millisecond, `m s` is a metre times a second. ISO 80000-1 allows either a
space or a half-high dot. siunitx's default is `inter-unit-product = \,`, and the
hand-written units in the notation table use the same `\,`, so the paper is
consistent. If you prefer dots, set it once and never mix:

```latex
\sisetup{inter-unit-product=\cdot}   % 1.2 kg · m^-3, a little wide
```

Do not reach for `\textperiodcentered` with T1 fonts: the glyph extracts as a
wrong character and breaks copy-paste and search.

The template also lowers the script size to 64 % of the body
(`\DeclareMathSizes{10.95}{10.95}{7}{5}`, plus a 12 pt variant), because the
default 73 % makes a superscript `-1` look almost as tall as the unit letter.
If you change the class option to `12pt`, the second declaration takes over; keep
both so the ratio stays at 64 %.

## 3. Equations

```latex
\begin{equation}
  \frac{\dd p}{\dd t} = -\frac{\gamma p A}{V}\,u(p)
  \label{eq:blowdown}
\end{equation}

\begin{align}
  u(p) &= \sqrt{\frac{2\gamma}{\gamma-1}\frac{p}{\rho}
          \left[1-\left(\frac{p_a}{p}\right)^{(\gamma-1)/\gamma}\right]},
  \label{eq:velocity}\\
  \dot m &= \rho A u .
  \label{eq:mdot}
\end{align}
```

Cross-reference: `Eq.~\eqref{eq:blowdown}`, `Eqs.~\eqref{eq:velocity}--\eqref{eq:mdot}`.

Piecewise:

```latex
C_d =
\begin{cases}
  1.0, & p/p_0 > 0.528 \quad (\text{choked}),\\
  0.8, & p/p_0 \le 0.528 \quad (\text{subsonic}).
\end{cases}
```

Vectors and matrices: `\vect{v}=\begin{pmatrix}v_x\\v_y\end{pmatrix}` (`\vect` is defined in the template).

## 4. Tables

### Three-line table with decimal alignment

```latex
\begin{table}[htbp]
  \centering
  \caption{Time to reach $0.3\,p_0$ versus hole diameter.}
  \label{tab:results}
  \begin{tabular}{@{}S[table-format=1.1]S[table-format=2.1]@{}}
    \toprule
    {$d$ (cm)} & {$t$ (s)} \\
    \midrule
    0.5 & 152.0 \\
    1.0 & 38.0 \\
    2.0 & 9.5 \\
    \bottomrule
  \end{tabular}
\end{table}
```

### Wide tables, in order of preference

1. `\small` or `\footnotesize`;
2. `\setlength{\tabcolsep}{4pt}`;
3. `tabular*{\textwidth}{@{\extracolsep{\fill}}...}`;
4. `\resizebox{\textwidth}{!}{...}` (last resort — the font shrinks);
5. split the table or transpose it.

### Merged cells

```latex
\multirow{2}{*}{A1} & ideal gas & $Z<1.002$ \\
                    & constant $c_p$ & $\Delta c_p<3\%$ \\
```

## 5. Figures

### Single figure

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.72\textwidth]{figures/blowdown.pdf}
  \caption{Pressure ratio versus time for three hole diameters.
  Lines: model; markers: ISS test data~\cite{ref4}.}
  \label{fig:blowdown}
\end{figure}
```

### Side-by-side subfigures

```latex
\begin{figure}[htbp]
  \centering
  \begin{subfigure}{0.48\textwidth}
    \includegraphics[width=\linewidth]{figures/a.pdf}
    \caption{Choked regime.}
  \end{subfigure}\hfill
  \begin{subfigure}{0.48\textwidth}
    \includegraphics[width=\linewidth]{figures/b.pdf}
    \caption{Subsonic regime.}
  \end{subfigure}
  \caption{Blow-down in the two regimes.}
  \label{fig:two}
\end{figure}
```

### Float placement

- `[htbp]` by default; `[t]` for two figures at a page top.
- Too many wandering floats: add `\FloatBarrier` at section ends (`placeins`).
- A figure must appear after its first reference and within the same section.

### TikZ sketch (optional)

```latex
\usepackage{tikz}
\begin{tikzpicture}[scale=0.9]
  \draw[thick] (0,0) rectangle (4,3);
  \draw[->,thick] (4,1.5) -- (5.4,1.5) node[right]{$u$};
  \node at (2,1.5) {$p_0,T_0$};
\end{tikzpicture}
```

## 6. Code appendix

```latex
\usepackage{listings}
\lstset{basicstyle=\ttfamily\footnotesize,breaklines=true,frame=single,
        numbers=left,numberstyle=\tiny,columns=fullflexible}
\begin{lstlisting}[language=Python,caption={Integration of Eq.~\eqref{eq:blowdown}.}]
import numpy as np
def blowdown(p0=101325.0, V=628.0, A=7.85e-5, gamma=1.4, dt=1e-3):
    ...
\end{lstlisting}
```

Long code: `\lstinputlisting[language=Python]{code/blowdown.py}` and ship the `code/` folder with the paper.

## 7. References

### Hand-written (most robust for a short list)

```latex
\begin{thebibliography}{99}
\bibitem{ref1} A.~Author, B.~Author, ``Title,'' \emph{Journal} \textbf{12}(3), 45--67 (2020).
\bibitem{ref2} C.~Author, \emph{Book Title}, 2nd ed.\ (Publisher, 2019), ch.~4.
\end{thebibliography}
```

### BibTeX (many entries)

```latex
\bibliographystyle{unsrt}   % numbered in citation order
\bibliography{references}
```

```bibtex
@article{kim2019,
  author  = {Kim, J. and Lee, S.},
  title   = {Blow-down of a pressurised module},
  journal = {J. Spacecraft},
  volume  = {56}, number = {3}, pages = {45--67}, year = {2019}
}
```

`unsrt` prints only cited entries — a forgotten `\cite` silently drops an entry, so verify the count with `check_pdf.py`.

## 8. Multi-file collaboration (people or agents)

```
paper/
├── main.tex            % preamble + \input only
├── sections/
│   ├── 01-intro.tex
│   ├── 02-problem.tex
│   ├── 03-assumptions.tex
│   ├── 04-model.tex
│   ├── 05-method.tex
│   ├── 06-results.tex
│   ├── 07-discussion.tex
│   ├── 08-sw.tex
│   └── 09-conclusion.tex
├── figures/
├── code/
└── references.bib
```

`main.tex`:

```latex
\input{sections/01-intro}
\input{sections/02-problem}
...
```

Rules:
- One owner per section; **never two agents editing `main.tex`**.
- Shared macros (`\vect`, `\dd`) live only in `main.tex`.
- Each section file is self-contained and does not rename other sections' labels.
- Rebuild immediately after every merge; conflicts surface at compile time.

## 9. Header and footer (team number on every page)

```latex
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small Team \teamnum}
\fancyhead[R]{\small Problem \problemltr}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.4pt}
```

With a `titlepage` environment, remember `\thispagestyle{plain}` and redefine `plain`, otherwise page 1 has no team number.

## 10. Common compile errors

| Message | Cause | Fix |
|---|---|---|
| `Undefined control sequence \SI` | siunitx not loaded | add `\usepackage{siunitx}` |
| `Command \unit already defined` | siunitx v3 already defines `\unit`/`\qty` | do not define macros with those names |
| `File 'figures/x.pdf' not found` | wrong path or extension | use a relative path, confirm the file exists |
| `Missing $ inserted` | maths outside maths mode | wrap in `$...$` |
| `There were undefined references` | label typo, or needs another pass | run `build.sh` again |
| `Overfull \hbox` | wide table, long URL, long equation | shrink font, use `\url`, split the equation |
| Garbled Chinese | pdflatex has no CJK | keep the paper English; for Chinese notes use xelatex + ctex |

## 11. Build commands

```bash
bash scripts/build.sh paper/main.tex   # latexmk, multiple passes, log gate
latexmk -C paper/main.tex              # clean intermediates
```

Ship only: `main.pdf`, `main.tex`, `sections/`, `figures/`, `code/`, `references.bib`.

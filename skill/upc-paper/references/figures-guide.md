# Figures and Tables: Standards and Recipes

Gold Medal papers carry a median of 14 figures and 1 table. Figures are what judges look at first and where most formatting deductions happen.

## 1. Hard rules

1. Caption **below** the figure, `Figure 3: ...`, one sentence stating what is plotted, under what conditions, and what it shows.
2. Both axes carry a quantity and a unit: `$t$ (s)`, `$p/p_0$`, `$\lambda$ (nm)`.
3. Text inside the figure ≥75% of body size (12 pt body → ≥9 pt in the figure).
4. Line width ≥1.2 pt, marker size ≥4 pt; readable in greyscale (use colour **and** line style **and** marker).
5. Vector (PDF/EPS) preferred; bitmaps ≥300 dpi, never JPEG (ringing artefacts).
6. One figure, one claim. Fewer than five curves means no legend box is needed.
7. Uncertainty must be visible: error bars, a shaded band, or a caption note that it is smaller than the marker.

## 2. Figure size

Text width is 6.5 in (Letter, 1-in margins). Common choices:

- single column: `width=0.7\textwidth` (≈4.5 in);
- full width: `width=\textwidth`;
- side by side: `0.48\textwidth` each.

Create the figure at its final size — do not export large and scale down, or the fonts shrink with it:

```python
FIGW = 4.5      # inches, matches 0.7\textwidth
fig, ax = plt.subplots(figsize=(FIGW, FIGW*0.62))
```

## 3. Publication-grade matplotlib setup

```python
import matplotlib as mpl
mpl.use("Agg")
mpl.rcParams.update({
    "pdf.fonttype": 42, "ps.fonttype": 42,   # embed TrueType, avoid Type 3
    "font.family": "serif",
    "font.serif": ["DejaVu Serif"],          # or "Times New Roman"
    "font.size": 9, "axes.labelsize": 9, "axes.titlesize": 9,
    "legend.fontsize": 8, "xtick.labelsize": 8, "ytick.labelsize": 8,
    "axes.linewidth": 0.8, "lines.linewidth": 1.4,
    "xtick.direction": "in", "ytick.direction": "in",
    "xtick.top": True, "ytick.right": True,
    "savefig.bbox": "tight", "savefig.pad_inches": 0.02,
})
```

Colour-blind-safe palette (Okabe–Ito):

```python
OKABE = ["#0072B2", "#D55E00", "#009E73", "#CC79A7",
         "#F0E442", "#56B4E9", "#E69F00", "#000000"]
```

## 4. Recipes for the common figure types

### 4.1 Family of curves from a parameter sweep (most common)

```python
import numpy as np
t = np.linspace(0, 160, 400)
for d, c, ls in [(0.5, OKABE[0], "-"), (1.0, OKABE[1], "--"), (2.0, OKABE[2], ":")]:
    ax.plot(t, 1/(1 + t*d*d/38), ls, color=c, label=rf"$d$ = {d} cm")
ax.set_xlabel(r"$t$ (s)"); ax.set_ylabel(r"$p/p_0$")
ax.set_xlim(0, 160); ax.set_ylim(0, 1.02)
ax.legend(frameon=False)
```

### 4.2 Model versus data (validation figure)

```python
ax.plot(t, model, "-", color=OKABE[0], label="model")
ax.errorbar(t_exp, p_exp, yerr=p_err, fmt="o", ms=4, mfc="white",
            mec=OKABE[1], ecolor=OKABE[1], capsize=2, label="experiment")
ax.legend(frameon=False)
```

### 4.3 Residual plot (the second validation figure)

```python
ax.axhline(0, color="0.5", lw=0.8, ls="--")
ax.plot(t_exp, (model_exp - p_exp)/p_exp*100, "o", ms=4, color=OKABE[0])
ax.set_ylabel(r"residual (\%)")
```

### 4.4 Uncertainty band

```python
ax.fill_between(t, lo, hi, color=OKABE[0], alpha=0.15, lw=0, label=r"$\pm20\%$ in $C_d$")
ax.plot(t, mid, color=OKABE[0], label="nominal")
```

### 4.5 Twin axes (different dimensions)

```python
ax2 = ax.twinx()
ax2.plot(t, T, color=OKABE[1], ls="--")
ax2.set_ylabel(r"$T$ (K)", color=OKABE[1])
ax.tick_params(axis="y", colors=OKABE[0])
```

### 4.6 Trajectory / phase portrait

```python
ax.plot(x, y, color=OKABE[0], lw=1.2)
ax.plot(x[0], y[0], "o", color=OKABE[1]); ax.annotate("start", (x[0], y[0]))
ax.set_aspect("equal")
```

### 4.7 Contour or heat map over a parameter space

```python
cs = ax.contourf(X, Y, Z, levels=20, cmap="viridis")
ax.contour(X, Y, Z, levels=[threshold], colors="k", linewidths=1)
fig.colorbar(cs, ax=ax, label=r"$t_{0.3}$ (s)")
```

### 4.8 Bar comparison across schemes

```python
ax.bar(x, mass, yerr=err, capsize=3, color=[OKABE[i] for i in range(len(x))])
ax.set_ylabel("mass (kg)")
```

## 5. Caption style

- One sentence: `Figure 4: Pressure ratio versus time for three hole diameters; lines are Eq. (1), markers are the ISS test data [4].`
- Must contain: conditions (parameter values), meaning of lines/markers, meaning of the error bars.
- Do not write "as can be seen in the figure"; do not repeat a body sentence.
- Subfigures: `(a) choked regime; (b) subsonic regime.`

## 6. Table standards

- Booktabs three-line tables; no vertical rules.
- Caption **above** the table, `Table 2: ...`.
- Units in the column head: `$d$ (cm)`, `$t$ (s)` — never repeated in every cell.
- Decimal-aligned numbers (`S` columns), consistent significant figures.
- Empty cell `--`, never 0 (0 is a value).
- Big tables may go to the appendix with a summary column in the body.

## 7. From data to figure

1. The computation writes CSV (`results/run01.csv`); never copy numbers by hand.
2. A per-figure script in your paper's `scripts/` folder reads that CSV, so figure and data stay traceable.
3. Save as `figures/fig3.pdf`, referenced as `\includegraphics{figures/fig3}`.
4. Keep script, CSV and figure together; the paper cites the figure, not the script.

## 8. Figure and table checklist

- [ ] Both axes show a quantity and a unit, with ticks
- [ ] Legend does not cover data; order matches the text
- [ ] Distinguishable in greyscale
- [ ] Uncertainty visible or explicitly discussed
- [ ] Caption states conditions and takeaway
- [ ] Every figure is referenced in the text (`Figure~\ref{}`), numbering continuous
- [ ] Vector export, fonts embedded
- [ ] Text ≥9 pt after scaling to text width

## 9. Anti-patterns

- 3-D bars and pie charts (low information density).
- Default matplotlib blue/orange, heavy frame, legend outside the axes — instantly reads "untouched".
- Twelve lines in one panel distinguished only by a legend.
- A truncated axis with no note.
- Screenshots or Excel exports pasted in (wrong resolution and fonts).
- A "Figure 1" that is never referenced (missing `\label`).

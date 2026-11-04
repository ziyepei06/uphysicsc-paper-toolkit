# Numbers, Units and Uncertainty

The most common criticism from UPC judges is "numbers without uncertainty". This file gives the rules to apply literally.

## 1. Significant figures

- Report uncertainty to 1–2 significant figures (usually 1; keep 2 when the leading digit is 1).
- Align the result with the uncertainty: `38 ± 3 s`, `1.25 ± 0.08 m`, `(3.2 ± 0.4) × 10^4 K`.
- Keep two extra digits in intermediate work; round once at the end.
- Never write `38.27 ± 3.1 s`, and never `38.0 ± 3 s` (mismatched precision).

Wrong → right:

| Wrong | Problem | Right |
|---|---|---|
| 38.2743 s | false precision | 38 s (or 38 ± 3 s) |
| 0.0001234 m | unreadable | $1.23\times10^{-4}$ m |
| 12000 m | ambiguous figures | $1.2\times10^{4}$ m |
| 5 m/s ± 12% | mixed forms | $5.0 \pm 0.6$ m/s |

## 2. Uncertainty propagation

### Analytic (independent, normal)

$$ \sigma_f^2=\sum_i\left(\frac{\partial f}{\partial x_i}\right)^2\sigma_{x_i}^2 $$

Example: $t=\dfrac{V}{A C_d u}$ gives

$$ \frac{\sigma_t}{t}=\sqrt{\left(\frac{\sigma_V}{V}\right)^2+\left(\frac{\sigma_A}{A}\right)^2+\left(\frac{\sigma_{C_d}}{C_d}\right)^2+\left(\frac{\sigma_u}{u}\right)^2} $$

### Numerical (when the model is complicated)

- Perturb each input by ±1σ, record the change in the output, add in quadrature (linear approximation).
- Or Monte Carlo: draw $10^4$ samples per input, take the 16/50/84 percentiles of the output.

```python
import numpy as np
rng = np.random.default_rng(0)
N = 20000
Cd = rng.normal(0.82, 0.05, N)
d  = rng.normal(0.010, 0.0002, N)
t  = blowdown_time(Cd, d)
lo, mid, hi = np.percentile(t, [16, 50, 84])
print(f"t = {mid:.1f} +{hi-mid:.1f}/-{mid-lo:.1f} s")
```

## 3. Error budget table (put this in the body)

| Source | Magnitude | Effect on result | Handling |
|---|---|---|---|
| Discharge coefficient $C_d$ | ±6% | ±19% | calibrated against experiment |
| Hole area $A$ | ±4% | ±8% | geometric measurement |
| Wall temperature $T_w$ | ±10 K | ±2% | sensitivity analysis |
| Numerical discretisation | — | 0.02% | step-halving test |
| **Total** | | **±21%** | dominant term: $C_d$ |

Combine in quadrature (independent) or linearly (conservative), and say which you used.

## 4. Validation metrics

- Relative deviation $\delta_i=(y_i^{\rm model}-y_i^{\rm exp})/y_i^{\rm exp}$; report the mean and the maximum absolute value.
- RMSE with units: $\rm RMSE=\sqrt{\frac1N\sum(y_i^{\rm model}-y_i^{\rm exp})^2}$.
- $R^2$ only for fits; for physical models prefer RMSE or relative deviation ($R^2$ is inflated by the range).
- State the validated interval: "within 8% over $1>p/p_0>0.35$", not a single number.

## 5. Sensitivity analysis

### One factor at a time

Vary each parameter by ±10%/±20% and draw a tornado plot:

```python
params = {"C_d": (0.7, 0.9), "T_w": (280, 300), "d": (0.009, 0.011)}
base = model()
rows = []
for k, (lo, hi) in params.items():
    rows.append((k, model(**{k: lo}) - base, model(**{k: hi}) - base))
```

In the text: "A ±20% change in $C_d$ shifts $t_{0.3}$ by ∓19%, whereas ±10 K in wall temperature shifts it by 2%."

### Multiple factors

- Few parameters (≤3): a 2-D contour with one isoline at the decision threshold (e.g. $t=80$ s).
- Many parameters: Latin hypercube sampling plus partial correlations or Sobol indices; if you cannot compute indices, say so.

## 6. Dimensional analysis and scaling laws

- List variables and dimensions, apply Buckingham π to reduce the space.
- Write the result as $t_{0.3}=\tau\,f(\Pi_1,\Pi_2)$ and fit $f$ to data.
- Scaling laws are a plus: `t ∝ d^{-2}`, `P ∝ T^4`, `h ∝ L^{2/3}` — with the range of validity.

Zero-order estimate for a hull breach:

$$ t \sim \frac{V}{A c_s},\qquad c_s=\sqrt{\gamma R T} $$

With $V=628$ m³, $A=7.85\times10^{-5}$ m², $c_s=340$ m/s this gives $t\sim2.4\times10^{4}$ s; the gap to the exact solution is exactly the pressure-ratio driving term you must add — such a comparison belongs in the Discussion.

## 7. Order-of-magnitude checks (after every calculation)

1. Are the units right? (dimensional check)
2. Is the magnitude plausible? (human, car, Earth scales)
3. Do the limits behave? $d\to0$, $m\to0$, $T\to0$.
4. How far from a known constant or literature value — how many orders of magnitude?
5. Is the sign right? (should the pressure rise or fall?)

## 8. Units and conversions

- SI by default; engineering units (atm, bar, kWh, km/h, °C) allowed, with a conversion at first use.
- Temperature: kelvin in equations, °C only in prose.
- Angles: radians in equations, degrees allowed on axes if labelled.
- Common conversions: 1 atm = 101 325 Pa; 1 bar = 10⁵ Pa; 1 eV = 1.602×10⁻¹⁹ J; 1 au = 1.496×10¹¹ m; 1 yr = 3.156×10⁷ s.

## 9. Typesetting numbers

- Thousands separator: thin space (`\num{12000}` → 12 000), never a comma.
- Ranges with an en dash: `10--20 km`.
- `\pm` for uncertainty, `\times` for multiplication, `\approx`, `\propto`.
- Percent: `8\%`, not `8 %`; use `\pm`/`\mp` to show direction.

## 10. Numerical self-check before submission

- [ ] Every result carries a unit
- [ ] Every key result carries an uncertainty or a range
- [ ] Significant figures consistent across text, tables, figures, summary
- [ ] Summary numbers = conclusion numbers = body numbers
- [ ] Error budget exists and names the dominant term
- [ ] At least one external validation or limit check
- [ ] At least one dimensional check written out
- [ ] Axis units match body units

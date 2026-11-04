# Releasing

Every release carries **all three archives**. A reader who follows
`/releases/latest` should never have to open an older release to find the
papers, which is exactly what went wrong in v1.0.1 (papers stayed behind on
v1.0.0 until it was fixed by hand).

| Asset | Built from | Size |
|---|---|---|
| `upc-latex-template.zip` | `template/` (without LaTeX by-products) | ~400 KB |
| `upc-paper-skill.zip` | `skill/upc-paper/` | ~120 KB |
| `upc-papers-2010-2025.zip` | `papers/` | ~96 MB |

## Build the two small archives

```bash
rm -rf /tmp/rel && mkdir -p /tmp/rel
cp -R skill/upc-paper /tmp/rel/upc-paper
cp -R template /tmp/rel/upc-latex-template
cd /tmp/rel
find . \( -name '*.aux' -o -name '*.log' -o -name '*.fls' -o -name '*.fdb_latexmk' \
        -o -name '*.out' -o -name '*.bbl' -o -name '*.blg' -o -name '*.toc' \
        -o -name '*.synctex*' -o -name 'main.pdf' \) -delete
zip -qr upc-paper-skill.zip upc-paper
zip -qr upc-latex-template.zip upc-latex-template
```

The papers archive changes only when the paper set changes; otherwise reuse the
bytes already published (download the previous asset rather than re-zipping, so
the checksum stays stable).

## Publish

```bash
git tag -a vX.Y.Z -m "vX.Y.Z — one line" && git push origin vX.Y.Z
gh release create vX.Y.Z /tmp/rel/upc-latex-template.zip /tmp/rel/upc-paper-skill.zip \
    /tmp/upc-papers-2010-2025.zip --notes-file /tmp/notes.md
```

Check afterwards that `gh release view vX.Y.Z --json assets` lists three assets
with state `uploaded`, and that `/releases/latest` resolves to the new tag.

## Before tagging

- `cd template && make clean && make` — `RESULT: PASS`, 11 pages, summary 202/300.
- Flip `\aiusedtrue` in `config.tex`, `make`, confirm the AI section appears,
  then flip it back.
- Unpack both archives into a clean directory, build there, and run
  `scripts/new_paper.sh 777 A`.

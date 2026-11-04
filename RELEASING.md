# Releasing

Every release carries **two archives**. A reader who follows `/releases/latest`
should never have to open an older release to find either one.

| Asset | Built from | Size |
|---|---|---|
| `upc-latex-template.zip` | `template/` (without LaTeX by-products) | ~500 KB |
| `upc-paper-skill.zip` | `skill/upc-paper/` (no compiled PDFs) | ~125 KB |

The papers are **not** an asset. They are the authors' copyright and live on
uphysicsc.com; `papers/README.md` links to them. Repackaging them was how v1.0.0
shipped a 96 MB archive that had no business being distributed under this
repository's name.

## Build the two archives

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

## Publish

```bash
git tag -a vX.Y.Z -m "vX.Y.Z — one line" && git push origin vX.Y.Z
gh release create vX.Y.Z /tmp/rel/upc-latex-template.zip /tmp/rel/upc-paper-skill.zip \
    --notes-file /tmp/notes.md
```

Check afterwards that `gh release view vX.Y.Z --json assets` lists exactly two
assets with state `uploaded`, and that `/releases/latest` resolves to the new tag.

## Before tagging

- `cd template && make clean && make` — `RESULT: PASS`, 13 pages, summary 200/300;
  `make demo` gives the 14-page sample with the AI appendix.
- Flip `\aiusedtrue` in `config.tex`, `make`, confirm the AI section appears,
  then flip it back.
- Unpack both archives into a clean directory, build there, and run
  `scripts/new_paper.sh 777 A`.
- `git ls-files | grep -i '\.pdf$'` — every hit must be a compiled example that
  this repository wrote itself, never a contest paper.

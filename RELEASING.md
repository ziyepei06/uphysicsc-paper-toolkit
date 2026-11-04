# Releasing

Every release carries **three archives**, matching the repository: the template,
the skill, and the 74 papers. A reader who follows `/releases/latest` should not
have to open an older release to find any of them.

| Asset | Built from | Size |
|---|---|---|
| `upc-latex-template.zip` | `template/` (without LaTeX by-products) | ~490 KB |
| `upc-paper-skill.zip` | `skill/upc-paper/` (no compiled PDFs) | ~125 KB |
| `upc-papers-2010-2025.zip` | `papers/` (year folders, `README.md`, `NOTICE.md`) | ~96 MB |

The papers archive carries the authors' copyright, not ours. It ships the PDFs
unmodified, `NOTICE.md` included, and the index inside links to the official copy
of every paper.

## Build the three archives

```bash
rm -rf /tmp/rel && mkdir -p /tmp/rel
cp -R skill/upc-paper /tmp/rel/upc-paper
cp -R template /tmp/rel/upc-latex-template
cp -R papers /tmp/rel/upc-papers
cd /tmp/rel
find . \( -name '*.aux' -o -name '*.log' -o -name '*.fls' -o -name '*.fdb_latexmk' \
        -o -name '*.out' -o -name '*.bbl' -o -name '*.blg' -o -name '*.toc' \
        -o -name '*.synctex*' -o -name 'main.pdf' \) -delete
zip -qr upc-paper-skill.zip upc-paper
zip -qr upc-latex-template.zip upc-latex-template
zip -qr upc-papers-2010-2025.zip upc-papers
```

## Publish

```bash
git tag -a vX.Y.Z -m "vX.Y.Z — one line" && git push origin vX.Y.Z
gh release create vX.Y.Z /tmp/rel/upc-latex-template.zip \
    /tmp/rel/upc-paper-skill.zip /tmp/rel/upc-papers-2010-2025.zip \
    --notes-file /tmp/notes.md
```

Check afterwards that `gh release view vX.Y.Z --json assets` lists exactly three
assets with state `uploaded`, and that `/releases/latest` resolves to the new tag.

## Before tagging

- `cd template && make clean && make` — `RESULT: PASS`, 13 pages, summary 198/300;
  `make demo` gives the 14-page sample with the AI appendix.
- Flip `\aiusedtrue` in `config.tex`, `make`, confirm the AI section appears,
  then flip it back.
- Unpack all three archives into a clean directory, build there, and run
  `scripts/new_paper.sh 777 A`.
- `git ls-files papers | grep -c '\.pdf$'` — must still be 74, and every entry must
  be a contest paper, never something this repository compiled.

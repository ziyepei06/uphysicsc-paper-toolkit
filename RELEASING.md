# Releasing

Every release carries **three archives**, matching the repository: the template,
the skill, and the 74 papers. A reader who follows `/releases/latest` should not
have to open an older release to find any of them.

| Asset | Built from | Size |
|---|---|---|
| `upc-latex-template.zip` | `template/` | ~480 KB |
| `upc-paper-skill.zip` | `skill/upc-paper/` | ~125 KB |
| `upc-papers-2010-2025.zip` | `papers/` (year folders, `README.md`, `NOTICE.md`) | ~96 MB |

The papers archive carries the authors' copyright, not ours. It ships the PDFs
unmodified, `NOTICE.md` included, and the index inside links to the official copy
of every paper.

## Before tagging

- `cd template && make clean && make` — `RESULT: PASS`, 13 pages, summary 198/300;
  `make demo` gives the 14-page sample with the AI appendix.
- Flip `\aiusedtrue` in `config.tex`, `make`, confirm the AI section appears,
  then flip it back.
- `git ls-files papers | grep -c '\.pdf$'` — must still be 74, and every entry must
  be a contest paper, never something this repository compiled.
- `git status` clean and `main` pushed: the tag goes on a commit that already
  exists on the remote.

## Tag, then build the archives from the tag

The archives come out of `git archive`, not out of the working tree, so build
by-products, `__pycache__` and locally generated PDFs cannot slip in: only what
the tag tracks is shipped.

```bash
git tag -a vX.Y.Z -m "vX.Y.Z — one line" && git push origin vX.Y.Z

rm -rf /tmp/rel && mkdir -p /tmp/rel && cd /tmp/rel
R=/path/to/uphysicsc-paper-toolkit
git -C "$R" archive --format=zip --prefix=upc-latex-template/ vX.Y.Z:template \
    -o upc-latex-template.zip
git -C "$R" archive --format=zip --prefix=upc-paper/ vX.Y.Z:skill/upc-paper \
    -o upc-paper-skill.zip
git -C "$R" archive --format=zip --prefix=upc-papers/ vX.Y.Z:papers \
    -o upc-papers-2010-2025.zip
```

`template/000A.pdf` is the committed 14-page sample and ships with the template on
purpose; it is tracked, so `git archive` includes it.

## Check the archives before publishing

```bash
for z in *.zip; do unzip -tq "$z" || echo "CORRUPT $z"; done
unzip -l upc-latex-template.zip | grep -E '\.(aux|log|pyc)|__pycache__' && echo "JUNK"
unzip -l upc-paper-skill.zip | grep -E '\.(aux|log|pyc)|__pycache__' && echo "JUNK"
unzip -q upc-latex-template.zip && cd upc-latex-template && make >/dev/null && make check
```

## Publish

```bash
gh release create vX.Y.Z upc-latex-template.zip upc-paper-skill.zip \
    upc-papers-2010-2025.zip --notes-file /tmp/notes.md
```

Then confirm that `gh release view vX.Y.Z --json assets` lists exactly three
assets with state `uploaded`, that `/releases/latest` resolves to the new tag, and
that each asset downloads and unzips to the expected top-level folder.

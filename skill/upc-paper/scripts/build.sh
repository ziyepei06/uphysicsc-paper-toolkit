#!/usr/bin/env bash
# UPC paper build: compile + log gate.
#   bash scripts/build.sh paper.tex [--keep]
# Compiles with latexmk (pdflatex), twice if needed, resolves bibliography,
# and fails loudly on undefined references, missing figures or real errors.
set -uo pipefail

TEX="${1:-paper.tex}"
if [[ ! -f "$TEX" ]]; then echo "ERROR: $TEX not found" >&2; exit 2; fi
DIR="$(cd "$(dirname "$TEX")" && pwd)"; BASE="$(basename "${TEX%.tex}")"
cd "$DIR" || exit 2

command -v latexmk >/dev/null || { echo "ERROR: latexmk not found (install TeX Live / MacTeX)" >&2; exit 2; }

echo "==> compiling $BASE.tex"
latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
        -synctex=1 "$BASE.tex" >/tmp/upc_build_stdout.log 2>&1
STATUS=$?

LOG="$BASE.log"
if [[ ! -f "$LOG" ]]; then echo "ERROR: no log produced"; tail -30 /tmp/upc_build_stdout.log; exit 1; fi

ERR=$(grep -nE '^!|LaTeX Error|Emergency stop' "$LOG" | head -20)
UNDEF_REF=$(grep -cE 'Reference .* undefined|Citation .* undefined' "$LOG")
MISSING=$(grep -oE "File \`[^']+' not found" "$LOG" | sort -u | head -10)
OVERFULL=$(grep -c 'Overfull \\hbox' "$LOG")
UNDERFULL=$(grep -c 'Underfull \\hbox' "$LOG")

echo "--- log summary"
PAGES=$(grep -oE "\([0-9]+ pages" "$LOG" | tail -1 | tr -d "(" )
echo "pages      : ${PAGES:-?}"
echo "undefined  : $UNDEF_REF"
echo "overfull   : $OVERFULL"
echo "underfull  : $UNDERFULL"
[[ -n "$MISSING" ]] && { echo "missing files:"; echo "$MISSING"; }
[[ -n "$ERR" ]] && { echo "errors:"; echo "$ERR"; }

FAIL=0
[[ $STATUS -ne 0 ]] && FAIL=1
[[ "$UNDEF_REF" -ne 0 ]] && { echo "ERROR: unresolved references/citations" >&2; FAIL=1; }
[[ -n "$MISSING" ]] && { echo "ERROR: missing input files (figures?)" >&2; FAIL=1; }
[[ "$OVERFULL" -gt 15 ]] && echo "WARNING: $OVERFULL overfull boxes -- check wide tables/URLs"

if [[ $FAIL -ne 0 ]]; then
  echo "BUILD FAILED -- fix the issues above (full log: $LOG)" >&2
  exit 1
fi
echo "==> ok: $BASE.pdf"

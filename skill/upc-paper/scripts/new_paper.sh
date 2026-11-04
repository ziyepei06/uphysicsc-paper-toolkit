#!/usr/bin/env bash
# Scaffold a UPC paper from the skill template.
#
# Usage:
#   scripts/new_paper.sh 778 A "Bouncing on a Trampoline"
#   scripts/new_paper.sh 778 A "Title" /path/to/work      # explicit parent dir
#
# Creates a full multi-file project from templates/project/:
#   <parent>/778A/main.tex, config.tex (team/problem/title filled in),
#   preamble.tex, refs.bib, sections/00..11, code/, scripts/, figures/,
#   notes/, Makefile, README.md, README.zh-CN.md

set -euo pipefail

if [ $# -lt 3 ]; then
  echo "usage: $0 <team> <A|B> <title> [parent-dir]" >&2
  exit 2
fi

TEAM="$1"
PROB="$(printf '%s' "$2" | tr '[:lower:]' '[:upper:]')"
TITLE="$3"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PARENT="${4:-$PWD}"
OUT="$PARENT/${TEAM}${PROB}"

case "$PROB" in
  A|B) ;;
  *) echo "problem must be A or B, got '$2'" >&2; exit 2 ;;
esac
case "$TEAM" in
  ''|*[!0-9]*) echo "team must be numeric, got '$TEAM'" >&2; exit 2 ;;
esac

if [ -e "$OUT" ]; then
  echo "refusing to overwrite existing $OUT" >&2
  exit 1
fi
if [ ! -d "$SKILL_DIR/templates/project" ]; then
  echo "project template not found under $SKILL_DIR/templates" >&2
  exit 1
fi

mkdir -p "$OUT"
# Copy the project skeleton, minus anything a build may have left behind.
( cd "$SKILL_DIR/templates/project" && tar -cf - \
    --exclude='*.aux' --exclude='*.log' --exclude='*.bbl' --exclude='*.blg' \
    --exclude='*.fls' --exclude='*.fdb_latexmk' --exclude='*.out' \
    --exclude='*.synctex.gz' --exclude='*.pdf' . ) | ( cd "$OUT" && tar -xf - )
mkdir -p "$OUT/figures"
cp "$SKILL_DIR/templates/project/figures/example.pdf" "$OUT/figures/" 2>/dev/null || true

# Title must survive sed: escape &, / and backslashes.
ESC_TITLE="$(printf '%s' "$TITLE" | sed -e 's/[\\/&]/\\&/g')"

sed -i '' -e "s|\\\\newcommand{\\\\teamnum}{000}|\\\\newcommand{\\\\teamnum}{$TEAM}|" \
          -e "s|\\\\newcommand{\\\\problemltr}{A}|\\\\newcommand{\\\\problemltr}{$PROB}|" \
          -e "s|\\\\newcommand{\\\\papertitle}{.*}|\\\\newcommand{\\\\papertitle}{$ESC_TITLE}|" \
          "$OUT/config.tex"

printf 'SKILL := %s\n' "$SKILL_DIR" > "$OUT/local.mk"

echo "created $OUT"
echo "  next: cd \"$OUT\" && make          # compile + compliance checks"
echo "        edit config.tex and sections/, then make pdf"

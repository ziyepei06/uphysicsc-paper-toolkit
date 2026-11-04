#!/usr/bin/env bash
# Install the upc-paper skill into an agent's skills directory.
#
#   ./install.sh                      # every directory that already exists
#   ./install.sh --target DIR         # exactly one directory
#   ./install.sh --link               # symlink instead of copy (repo stays authoritative)
#
# Safe to re-run: an existing installation is moved aside, not deleted.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$here/skill/upc-paper"
mode="copy"
targets=()

while [ $# -gt 0 ]; do
  case "$1" in
    --target) targets+=("$2"); shift 2 ;;
    --link)   mode="link"; shift ;;
    -h|--help) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

if [ ${#targets[@]} -eq 0 ]; then
  for d in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
    [ -d "$d" ] && targets+=("$d")
  done
fi

if [ ${#targets[@]} -eq 0 ]; then
  echo "No skills directory found. Create one, or pass --target DIR." >&2
  echo "  e.g. ./install.sh --target ~/.claude/skills" >&2
  exit 1
fi

[ -d "$src" ] || { echo "missing $src" >&2; exit 1; }

for dir in "${targets[@]}"; do
  mkdir -p "$dir"
  dest="$dir/upc-paper"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    old="$dest.aside-$(date +%Y%m%d-%H%M%S)"
    mv "$dest" "$old"
    echo "moved existing $dest -> $old"
  fi
  if [ "$mode" = "link" ]; then
    ln -s "$src" "$dest"
    echo "linked $dest -> $src"
  else
    cp -R "$src" "$dest"
    echo "installed $dest"
  fi
done

echo
echo "Installed. Ask your agent about UPC paper formatting to use it."
echo "To write: cp -R \"$here/template\" ~/Desktop/204B && cd ~/Desktop/204B && make"

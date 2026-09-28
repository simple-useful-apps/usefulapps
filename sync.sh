#!/bin/sh
# Copy each app's docs site (HTML + assets) from its own repo into this hub.
# Each app repo's docs/ folder is the source of truth; never edit the copies here.
#
#   ./sync.sh            copy, then show what changed
#   ./sync.sh --check    exit non-zero if any copy is out of date (e.g. before a push)
set -eu

cd "$(dirname "$0")"
projects="${PROJECTS:-$HOME/Projects}"

for app in theoldpod takes chatfolio; do
  rsync -a --delete --exclude='.DS_Store' --include='*.html' --include='assets/***' --exclude='*' \
    "$projects/$app/docs/" "$app/"
  # Pages show the icon at 96px; publish a 2x copy instead of the 1024px master.
  for png in "$app"/assets/*.png; do
    if [ -e "$png" ]; then sips --resampleHeightWidthMax 192 "$png" >/dev/null; fi
  done
done

if [ "${1:-}" = "--check" ]; then
  test -z "$(git status --porcelain -- theoldpod takes chatfolio)" ||
    { echo "App docs are out of date; run ./sync.sh and commit." >&2; exit 1; }
else
  git status --short -- theoldpod takes chatfolio
fi

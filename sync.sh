#!/bin/sh
# Copy each app's docs site (HTML + assets) from its own repo into this hub,
# then show what changed. Each app repo's docs/ folder is the source of truth;
# never edit the copies here.
set -eu

cd "$(dirname "$0")"
projects="${PROJECTS:-$HOME/Projects}"
apps="theoldpod takes chatfolio"

for app in $apps; do
  rsync -a --delete --exclude='.DS_Store' --include='*.html' --include='assets/***' --exclude='*' \
    "$projects/$app/docs/" "$app/"
  # Pages show the icon at 96px; publish a 2x copy instead of the 1024px master.
  for png in "$app"/assets/*.png; do
    if [ -e "$png" ]; then sips --resampleHeightWidthMax 192 "$png" >/dev/null; fi
  done
done

git status --short -- $apps

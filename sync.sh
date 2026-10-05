#!/bin/sh
# Copy each app's docs site (HTML + assets) from its own repo into this hub,
# then show what changed. Each app repo's docs/ folder is the source of truth;
# never edit the copies here.
set -eu

cd "$(dirname "$0")"
projects="${PROJECTS:-$HOME/Projects}"

# Live apps get their whole docs site. Coming-soon apps get only their icon,
# so the hub can show a dimmed row but no page is published.
# To launch an app, move it from soon to apps, run this, and give its row in
# index.html a link (see README).
apps="theoldpod"
soon="takes chatfolio"

for app in $apps; do
  rsync -a --delete --exclude='.DS_Store' --include='*.html' --include='assets/***' --exclude='*' \
    "$projects/$app/docs/" "$app/"
done
for app in $soon; do
  rsync -a --delete --delete-excluded --include='assets/' --include='assets/icon.*' --exclude='*' \
    "$projects/$app/docs/" "$app/"
done

# Pages show the icon at up to 80px; publish a 2x-plus copy instead of the 1024px master.
for png in */assets/*.png; do
  sips --resampleHeightWidthMax 192 "$png" >/dev/null
done

git status --short -- $apps $soon

# Simple Useful Apps — simple-useful-apps.org

The hub site for the Simple Useful Apps series: a single static page introducing
the apps and the philosophy, plus a copy of each app's documentation site.

No build step, no JavaScript. Plain HTML, one stylesheet, and one self-hosted
font (Instrument Sans, SIL Open Font License).

## Layout

- `index.html` + `assets/site.css` — the hub page and house stylesheet
- `theoldpod/`, `takes/`, `chatfolio/` — copies of each app repo's `docs/` site
  (HTML + assets only)
- `sync.sh` — refreshes the app copies from their repos
- `CONTRIBUTING.md` — how to report bugs and send changes (linked from the hub)
- `CNAME` — custom domain for GitHub Pages
- `.nojekyll` — tells GitHub Pages to serve files as-is

## Maintenance

Each app repo's `docs/` folder is the source of truth — never edit the copies here.
When an app's docs change, re-sync and commit:

```sh
./sync.sh   # copy every app's HTML + assets, then show what changed
```

The script mirrors deletions too, and publishes PNG icons at 192px (more than 2× the
80px they're shown at) rather than the 1024px masters. It expects the app repos
in `~/Projects`; set `PROJECTS=/some/dir` to override.

## One-time deploy steps

1. Create a GitHub repo (e.g. `mattreed555/usefulapps`) and push this folder to `main`.
2. In the repo settings, enable **Pages** → deploy from branch → `main`, root (`/`).
3. Point DNS at GitHub Pages:
   - Apex `A` records: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - Optional `www` `CNAME` record → `mattreed555.github.io`
4. In the repo's Pages settings, set the custom domain to `simple-useful-apps.org`
   and enable **Enforce HTTPS** once the certificate is issued.
5. Verify the domain under your GitHub account's **Settings → Pages → Verified
   domains** (a `TXT` record). This stops anyone else from claiming the domain
   on GitHub Pages if this repo is ever renamed or deleted.

## Local preview

```sh
python3 -m http.server
# then open http://localhost:8000
```

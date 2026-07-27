# Matt's Useful Apps — mattsusefulapps.org

The hub site for the "Matt's Useful Apps" series: a single static page introducing
the apps and the philosophy, plus a copy of each app's documentation site.

No build step, no JavaScript. Plain HTML and one stylesheet.

## Layout

- `index.html` + `assets/site.css` — the hub page and house stylesheet
- `theoldpod/`, `takes/`, `chatfolio/` — copies of each app repo's `docs/` site
  (HTML + assets only)
- `CNAME` — custom domain for GitHub Pages
- `.nojekyll` — tells GitHub Pages to serve files as-is

## Maintenance

Each app repo's `docs/` folder is the source of truth. When an app's docs change,
re-copy its site files here:

```sh
cp ~/Projects/<app>/docs/*.html <app>/
cp -R ~/Projects/<app>/docs/assets/ <app>/assets/
```

## One-time deploy steps

1. Create a GitHub repo (e.g. `mattreed555/usefulapps`) and push this folder to `main`.
2. In the repo settings, enable **Pages** → deploy from branch → `main`, root (`/`).
3. Register `mattsusefulapps.org` and point DNS at GitHub Pages:
   - Apex `A` records: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - Optional `www` `CNAME` record → `mattreed555.github.io`
4. In the repo's Pages settings, set the custom domain to `mattsusefulapps.org`
   and enable **Enforce HTTPS** once the certificate is issued.

## Local preview

```sh
python3 -m http.server
# then open http://localhost:8000
```

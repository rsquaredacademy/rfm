# tools/

Build helpers for the pkgdown site. They are not part of the R package
(`docs/`, `pkgdown/` and `docs-dev/` are listed in `.Rbuildignore`), but
they do live in this directory so the site fixes are reproducible.

## `fix-site.R` — post-build site fixes

Run from the package root after every `pkgdown::build_site()`:

```sh
Rscript tools/fix-site.R
```

It performs three fixes that pkgdown 2.x cannot do on its own:

1. **Removes rendered admin pages.** pkgdown renders every `*.md` file
   in the package root and in `.github/` as a documentation page, so
   `AGENTS.md` shows up as `docs/AGENTS.html` (and as a `docs/AGENTS.md`
   copy for the LLM index). `AGENTS.md` has to stay at the repo root for
   agent tooling, and moving it to `.github/` does not help because
   pkgdown renders `.github/*.md` as well, so the script deletes the
   stale output. `docs/ISSUE_TEMPLATE.*` is a leftover from an older
   build and is removed too. (`ISSUE_TEMPLATE.md` is no longer in the
   package root; it lives in `.github/ISSUE_TEMPLATE/` as issue forms.)
2. **Adds canonical links.** Every `docs/**/*.html` page gets exactly one
   `<link rel="canonical" href="https://rfm.rsquaredacademy.com/<path>">`
   tag (`index.html` points at the site root `/`). pkgdown's redirect
   stubs (alias pages with a `<meta http-equiv="refresh">` and
   `noindex`) get a canonical pointing at the page they redirect to; the
   Search Console verification file `google*.html` is skipped. pkgdown has
   no built-in canonical option, and the alternative — a `template:
   includes: in_header` snippet — would have to inject the tag with
   JavaScript, which crawlers are not required to run. A static tag
   written into the files is the reliable option, so the site is built
   and then patched.
3. **Cleans `sitemap.xml`.** pkgdown builds the sitemap from every
   `*.html` file in `docs/`, which includes `404.html`, the Google
   verification file, and admin pages such as `AGENTS.html`,
   `ISSUE_TEMPLATE.html` and `CONDUCT.html`. The script rewrites the
   sitemap so it lists only reader-facing pages that actually exist.

The script is idempotent and exits with an error if a page does not end
up with exactly one canonical link.

## Order of operations

```sh
Rscript -e 'pkgdown::build_site()'
Rscript tools/fix-site.R
```

Afterwards commit `docs/` together with the source changes.

# C19 — rfm pkgdown site indexing fixes (rfmsite1)

**Date:** 2026-11-16
**Branch:** `task/rfm-site-c19` (based on `origin/master` @ `1c93da5`, rfm 0.5.1)
**Toolchain:** R 4.6.1, pkgdown 2.2.1, pandoc 3.12.1, static site in `docs/` (GitHub Pages, `docs/CNAME` = `rfm.rsquaredacademy.com`)
**Commit:** `site: robots.txt, canonical links, sitemap clean-up and contributing link (rfmsite1)`

No package code was changed: `R/`, `man/`, `tests/`, `vignettes/` and `DESCRIPTION` are
untouched. Everything below is site-only (`pkgdown/`, `docs/`, `tools/`).

## Files changed

| File | Change |
| :--- | :--- |
| `pkgdown/assets/robots.txt` | **new** — copied to `docs/robots.txt` by every `pkgdown::build_site()` |
| `docs/robots.txt` | **new** (build output) |
| `tools/fix-site.R` | **new** — post-build step: canonical links + sitemap filter + stale admin page removal |
| `tools/README.md` | **new** — documents the post-build step, its order and why it is static |
| `docs/sitemap.xml` | regenerated and filtered (48 → 44 URLs) |
| `docs/CONTRIBUTING.html`, `docs/CONTRIBUTING.md` | **new** (the `CONTRIBUTING.html` link target now exists) |
| `docs/AGENTS.html`, `docs/AGENTS.md` | **deleted** (stale rendered admin page) |
| `docs/ISSUE_TEMPLATE.html`, `docs/ISSUE_TEMPLATE.md` | **deleted** (stale rendered admin page) |
| 55 `docs/**/*.html` | one `<link rel="canonical">` added to each (incl. `404.html`, not the Google file) |
| rest of `docs/` | full `pkgdown::build_site()` rebuild (0.5.0 → 0.5.1 navbar/footer, refreshed README rendering, current plotly/crosstalk deps) |

Nothing was committed for `_pkgdown.yml`; no course link (E10) was added.

## 1. robots.txt

`pkgdown/assets/robots.txt` (77 bytes), copied verbatim to `docs/robots.txt`:

```text
User-agent: *
Allow: /

Sitemap: https://rfm.rsquaredacademy.com/sitemap.xml
```

It is copied by `pkgdown::init_site()` (`copy_assets()`), so every rebuild keeps it. No
`Disallow` rules were added: `404.html` and the Google file are kept out of the sitemap
instead, which is the signal that matters here.

## 2. Canonical links — approach and why

pkgdown 2.2.1 has no canonical URL option and no template variable that exposes the
current page path. The only built-in hook, `template: includes: in_header`, is a *static*
HTML fragment inserted into every page's `<head>`; it cannot know which page it is on.
Producing a per-page canonical there would require JavaScript (which Googlebot may
execute but is not required to), so that route was rejected.

Instead `tools/fix-site.R` runs after `pkgdown::build_site()` and writes a static tag
before `</head>` on every page:

```html
<link rel="canonical" href="https://rfm.rsquaredacademy.com/<page path>">
```

- `docs/index.html` → `https://rfm.rsquaredacademy.com/` (site root, not `/index.html`).
- Every other page → its own `.html` path, e.g. `.../articles/rfm-introduction.html`.
- `docs/google02e424888b5e2def.html` is skipped: it is a 53-byte verification file,
  not a page.
- pkgdown's 9 redirect stubs (alias pages such as `reference/rfm_plot_median_frequency.html`,
  which carry `<meta http-equiv="refresh">` + `<meta name="robots" content="noindex">`
  and are excluded from the sitemap by pkgdown itself) get a canonical pointing at the
  **redirect target**, not at the stub. A self-canonical on a `noindex` redirect would
  contradict both signals.

The script is idempotent (it strips previously inserted canonical tags first) and ends
with a hard check that every processed page has exactly one canonical tag.

## 3. Sitemap clean-up

### Source-level changes

- `ISSUE_TEMPLATE.md` is no longer in the package root (it lives in
  `.github/ISSUE_TEMPLATE/` as issue forms), so pkgdown no longer renders it; the stale
  `docs/ISSUE_TEMPLATE.html` / `.md` outputs were deleted.
- `AGENTS.md` had to stay at the repo root: moving it to `.github/` does **not** stop
  pkgdown 2.2.1, because `package_mds()` renders every `*.md` in the package root *and*
  every `*.md` in `.github/` (that is also how `.github/CONTRIBUTING.md` becomes
  `CONTRIBUTING.html`). `.Rbuildignore` does not affect pkgdown either — pkgdown reads
  the source tree, not the tarball. The rendered `docs/AGENTS.html` / `.md` are therefore
  removed by `tools/fix-site.R` after each build (see follow-ups for the upstream option).
- `CONDUCT.html` is a public community page but not reader documentation; it stays on
  the site and is kept out of the sitemap.
- `404.html` stays as a page, excluded from the sitemap.
- `docs/google02e424888b5e2def.html` is kept in place (Search Console verification) and
  excluded from the sitemap only.

pkgdown builds `sitemap.xml` from *every* `*.html` file found under `docs/`
(`get_site_paths()`), including stale pages and files it did not generate, so the filter
has to run after the build. `tools/fix-site.R` additionally drops any URL whose file no
longer exists.

### Sitemap URLs before (committed `docs/sitemap.xml`, 48 URLs)

```text
https://rfm.rsquaredacademy.com/404.html
https://rfm.rsquaredacademy.com/AGENTS.html
https://rfm.rsquaredacademy.com/articles/case-study.html
https://rfm.rsquaredacademy.com/articles/index.html
https://rfm.rsquaredacademy.com/articles/Introduction_to_RFM.html
https://rfm.rsquaredacademy.com/articles/rfm-customer-level-data.html
https://rfm.rsquaredacademy.com/articles/rfm-introduction.html
https://rfm.rsquaredacademy.com/articles/rfm-transaction-level-data.html
https://rfm.rsquaredacademy.com/articles/tests_and_coverage.html
https://rfm.rsquaredacademy.com/authors.html
https://rfm.rsquaredacademy.com/CONDUCT.html
https://rfm.rsquaredacademy.com/google02e424888b5e2def.html
https://rfm.rsquaredacademy.com/index.html
https://rfm.rsquaredacademy.com/ISSUE_TEMPLATE.html
https://rfm.rsquaredacademy.com/LICENSE-text.html
https://rfm.rsquaredacademy.com/LICENSE.html
https://rfm.rsquaredacademy.com/news/index.html
https://rfm.rsquaredacademy.com/reference/index.html
https://rfm.rsquaredacademy.com/reference/rfm.html
https://rfm.rsquaredacademy.com/reference/rfm_barchart_data.html
https://rfm.rsquaredacademy.com/reference/rfm_create_report.html
https://rfm.rsquaredacademy.com/reference/rfm_data.html
https://rfm.rsquaredacademy.com/reference/rfm_data_customer.html
https://rfm.rsquaredacademy.com/reference/rfm_data_orders.html
https://rfm.rsquaredacademy.com/reference/rfm_heatmap_data.html
https://rfm.rsquaredacademy.com/reference/rfm_hist_data.html
https://rfm.rsquaredacademy.com/reference/rfm_launch_app.html
https://rfm.rsquaredacademy.com/reference/rfm_launch_shiny_app.html
https://rfm.rsquaredacademy.com/reference/rfm_mr_plot.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_bar_chart.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_heatmap.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_histogram.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_histograms.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_median_recency.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_order_dist.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_revenue_dist.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment_scatter.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment_summary.html
https://rfm.rsquaredacademy.com/reference/rfm_rm_plot.html
https://rfm.rsquaredacademy.com/reference/rfm_segment.html
https://rfm.rsquaredacademy.com/reference/rfm_segment_summary.html
https://rfm.rsquaredacademy.com/reference/rfm_table.html
https://rfm.rsquaredacademy.com/reference/rfm_table_customer.html
https://rfm.rsquaredacademy.com/reference/rfm_table_customer_2.html
https://rfm.rsquaredacademy.com/reference/rfm_table_order.html
https://rfm.rsquaredacademy.com/reference/segmentr.html
https://rfm.rsquaredacademy.com/SUPPORT.html
```

The intermediate sitemap written by `build_site()` had 49 URLs (the committed one plus
the newly rendered `CONTRIBUTING.html`).

### Sitemap URLs after (44 URLs)

```text
https://rfm.rsquaredacademy.com/articles/case-study.html
https://rfm.rsquaredacademy.com/articles/index.html
https://rfm.rsquaredacademy.com/articles/Introduction_to_RFM.html
https://rfm.rsquaredacademy.com/articles/rfm-customer-level-data.html
https://rfm.rsquaredacademy.com/articles/rfm-introduction.html
https://rfm.rsquaredacademy.com/articles/rfm-transaction-level-data.html
https://rfm.rsquaredacademy.com/articles/tests_and_coverage.html
https://rfm.rsquaredacademy.com/authors.html
https://rfm.rsquaredacademy.com/CONTRIBUTING.html
https://rfm.rsquaredacademy.com/index.html
https://rfm.rsquaredacademy.com/LICENSE-text.html
https://rfm.rsquaredacademy.com/LICENSE.html
https://rfm.rsquaredacademy.com/news/index.html
https://rfm.rsquaredacademy.com/reference/index.html
https://rfm.rsquaredacademy.com/reference/rfm.html
https://rfm.rsquaredacademy.com/reference/rfm_barchart_data.html
https://rfm.rsquaredacademy.com/reference/rfm_create_report.html
https://rfm.rsquaredacademy.com/reference/rfm_data.html
https://rfm.rsquaredacademy.com/reference/rfm_data_customer.html
https://rfm.rsquaredacademy.com/reference/rfm_data_orders.html
https://rfm.rsquaredacademy.com/reference/rfm_heatmap_data.html
https://rfm.rsquaredacademy.com/reference/rfm_hist_data.html
https://rfm.rsquaredacademy.com/reference/rfm_launch_app.html
https://rfm.rsquaredacademy.com/reference/rfm_launch_shiny_app.html
https://rfm.rsquaredacademy.com/reference/rfm_mr_plot.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_bar_chart.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_heatmap.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_histogram.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_histograms.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_median_recency.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_order_dist.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_revenue_dist.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment_scatter.html
https://rfm.rsquaredacademy.com/reference/rfm_plot_segment_summary.html
https://rfm.rsquaredacademy.com/reference/rfm_rm_plot.html
https://rfm.rsquaredacademy.com/reference/rfm_segment.html
https://rfm.rsquaredacademy.com/reference/rfm_segment_summary.html
https://rfm.rsquaredacademy.com/reference/rfm_table.html
https://rfm.rsquaredacademy.com/reference/rfm_table_customer.html
https://rfm.rsquaredacademy.com/reference/rfm_table_customer_2.html
https://rfm.rsquaredacademy.com/reference/rfm_table_order.html
https://rfm.rsquaredacademy.com/reference/segmentr.html
https://rfm.rsquaredacademy.com/SUPPORT.html
```

Dropped (5): `404.html`, `AGENTS.html`, `CONDUCT.html`,
`google02e424888b5e2def.html`, `ISSUE_TEMPLATE.html`. Added: `CONTRIBUTING.html`.
Verification: `grep -E "AGENTS|ISSUE_TEMPLATE|CONDUCT|404\.html|google" docs/sitemap.xml`
finds nothing, and every remaining URL maps to a file that exists in `docs/`.

## 4. Broken CONTRIBUTING link

The task described a `CONTRIBUTING.MD` file with an uppercase extension. There is no such
file in this tree: the contributing guide already lives at `.github/CONTRIBUTING.md`
(lowercase `.md`) and is tracked since commit `e66a6c9`. The link on the home page
(`docs/index.html`, sidebar "Community → Contributing guide") points at
`CONTRIBUTING.html`, which was simply missing because the last site build predated that
file. `pkgdown::build_site()` now renders `.github/CONTRIBUTING.md` to
`docs/CONTRIBUTING.html`:

```text
docs/CONTRIBUTING.html  (8439 bytes, <title>Contributing to rfm • rfm</title>)
docs/index.html: href="CONTRIBUTING.html"
```

No rename was needed and no link was changed. The link resolves.

## 5. Case-study title ("segmentr")

`docs/articles/case-study.html` is a stale pkgdown **1.x** page (Bootstrap 3, navbar
brand `segmentr`) left in `docs/` from the pre-0.5.0 site; there is no
`vignettes/case-study.Rmd` and no other source for it in this repository (the only
vignette is `vignettes/rfm-introduction.Rmd`). It is therefore **not** fixable from
source here — see follow-ups. The same applies to
`articles/Introduction_to_RFM.html`, a legacy duplicate of `articles/rfm-introduction.html`.

## 6. Redirects

No redirects were added (`_pkgdown.yml` untouched, no redirect config, no
`<meta refresh>` stubs created by hand). GitHub Pages cannot do server-side redirects, so
legacy URLs are left to 404 or to pkgdown's own alias stubs.

## Checks performed

All commands run from the worktree root with a temporary R library
(`pkgdown::build_site()` installs rfm from this tree into a temp lib).

**Build**

```text
Rscript -e 'pkgdown::build_site()'      -> exit 0
Rscript tools/fix-site.R                 -> exit 0
  Removed stale admin files: AGENTS.html, AGENTS.md, ISSUE_TEMPLATE.html, ISSUE_TEMPLATE.md
  Inserted canonical links into 55 HTML pages (9 redirect stubs point at their target)
  Sitemap: kept 44 of 49 URLs (5 dropped)
  OK: one canonical link on each of 55 pages
```

**Canonical links** (`docs/**/*.html`, Google verification file excluded):

```text
html pages checked (google file excluded): 55
  of which redirect stubs: 9
pages with exactly one canonical: 55
pages with != 1 canonical: 0
pages with wrong href: 0
```

Cross-check with grep: the only `docs/**/*.html` file without a canonical tag is
`docs/google02e424888b5e2def.html`, and no page has more than one
(`grep -c 'rel="canonical"'` = 1 everywhere else).

**robots.txt**

```text
docs/robots.txt exists (77 bytes), content identical to pkgdown/assets/robots.txt
```

**Sitemap**

```text
committed before: 48 URLs
build output:     49 URLs
after fix-site.R: 44 URLs; excluded pages all absent; every URL exists on disk
```

**CONTRIBUTING**

```text
docs/CONTRIBUTING.html exists; docs/index.html contains href="CONTRIBUTING.html"
```

**Clean archive build**

```text
git archive HEAD | tar -x -C .rfmsite1-tmp/archive
cd .rfmsite1-tmp/archive && R CMD build .    -> exit 0, rfm_0.5.1.tar.gz
tar tzf rfm_0.5.1.tar.gz | grep -E '^rfm/(docs|pkgdown|docs-dev|\.github)/'  -> no matches
tar tzf rfm_0.5.1.tar.gz | grep -E 'AGENTS|CONTRIBUTING|robots'             -> no matches
```

`.Rbuildignore` already contained `^docs$`, `^pkgdown$`, `^docs-dev$`, `^\.github$` and
`^AGENTS\.md$`; nothing had to be added. `tools/` ships in the tarball (it already
shipped with the README screenshots), including `tools/fix-site.R` and
`tools/README.md`.

**Scratch:** all temporary files were kept under `.rfmsite1-tmp/` and deleted before the
commit.

## Follow-ups (not done here)

1. **`articles/case-study.html` still says "segmentr".** The page is a leftover pkgdown
   1.x render with no source in this repository. Either delete it (and accept that
   external links to `/articles/case-study.html` 404, since GitHub Pages cannot
   redirect) or recover the source from the `segmentr` repository and rebuild it as an
   `rfm` article. Same decision needed for `articles/Introduction_to_RFM.html`, the
   pkgdown-1 duplicate of `articles/rfm-introduction.html`. Both are still listed in
   `sitemap.xml` today; they were left alone because deleting live URLs was out of C19's
   scope.
2. **Legacy pkgdown-1 reference pages** are still served and sitemap-listed, with no
   current topic behind them: `reference/rfm_hist_data.html`,
   `reference/rfm_launch_shiny_app.html`, `reference/rfm_mr_plot.html`,
   `reference/rfm_plot_histograms.html`, `reference/rfm_table.html`,
   `reference/segmentr.html`. (`reference/rfm.html`, `rfm_plot_segment.html` and
   `rfm_segment.html` are current man pages and should stay.) Stale `reference/libs/`
   copies remain as well (`crosstalk-1.1.0.1`, `htmlwidgets-1.5.4`,
   `plotly-*-4.10.2/4.10.3/4.11.0`, `plotly-htmlwidgets-css-2.11.1`,
   `plotly-main-2.11.1`). They describe an older API and dilute the sitemap; a `git rm`
   of the ones with no current topic (plus a redirect/noindex decision) is the next step.
3. **Stopping pkgdown from rendering `AGENTS.md` at the source.** pkgdown 2.2.1 renders
   every root `*.md` and every `.github/*.md`, and there is no config to skip one, so
   `AGENTS.md` can only be kept out of `docs/` by the post-build step. Options: file an
   upstream pkgdown feature request for an ignore list, or rename the file to something
   pkgdown does not glob (breaks agent tooling that expects `AGENTS.md` at the root).
   Until then, `tools/fix-site.R` must run after every `build_site()`; this is documented
   in `tools/README.md`.
4. **Post-build step is not automated.** There is no site workflow in `.github/workflows/`
   that runs `build_site()`; whoever builds the site must remember the second command.
   Consider adding an R script or Make target that runs both in order.
5. **Meta descriptions** are still missing on many reference/article pages (the audit
   counted 21). Adding `description` fields to vignette YAML and roxygen would fix that
   and is independent of C19.
6. **`docs/_headers`** is a Netlify header file and has no effect on GitHub Pages. Either
   remove it or move the security headers to the hosting layer if the site ever leaves
   Pages.
7. **Uppercase page filenames** (`LICENSE.html`, `LICENSE-text.html`, `SUPPORT.html`,
   `CONDUCT.html`, `CONTRIBUTING.html`) are fine on GitHub Pages (case-sensitive, files
   exist), but they were the source of the audit's "301 redirect" findings on a
   case-insensitive CDN. If the site is ever served through such a layer, these URLs will
   redirect again; canonical tags now point at the uppercase paths, so the alternative
   would be lower-case page names plus redirects.

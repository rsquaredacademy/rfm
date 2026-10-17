# AGENTS.md

R package `rfm` (CRAN): recency / frequency / monetary customer
segmentation. Standard R package layout.

## Branches

- Development happens on `develop`; releases are merged to `master`.
- CI (`R-CMD-check`, coverage via codecov) runs on both branches.

## Common commands

`devtools``::`[`test`](https://devtools.r-lib.org/reference/test.html)`(``)`` ``# all tests`` ``devtools``::`[`test`](https://devtools.r-lib.org/reference/test.html)`(``filter ``=`` ``"rfm-plots"``)`` ``# one file: tests/testthat/test-rfm-plots.R`` ``devtools``::`[`document`](https://devtools.r-lib.org/reference/document.html)`(``)`` ``# regenerate man/*.Rd from roxygen`` ``devtools``::`[`build_readme`](https://devtools.r-lib.org/reference/build_readme.html)`(``)`` ``# README.md is generated from README.Rmd`` ``rcmdcheck``::`[`rcmdcheck`](http://r-lib.github.io/rcmdcheck/reference/rcmdcheck.md)`(``)`` ``# pre-CRAN check; target is 0 errors/warnings/notes`` ``pkgdown``::`[`build_site`](https://pkgdown.r-lib.org/reference/build_site.html)`(``)`` ``# site config in _pkgdown.yml`

## Documentation rules

- Edit roxygen comments in `R/*.R`; never edit `man/*.Rd` directly
  (generated).
- Edit `README.Rmd`, never `README.md`.
- Docs use roxygen2 Markdown syntax.
- Add user-facing changes as a bullet at the top of `NEWS.md` under “rfm
  (development version)”.
- Follow the tidyverse style guide; do not restyle code unrelated to
  your change.

## Testing quirks

- testthat edition 3 (`Config/testthat/edition: 3` in DESCRIPTION).
- All plot tests use `skip_on_cran()`, so they only run locally/CI — run
  them locally before pushing; CRAN never exercises them.
- Static ggplot plots are verified with **vdiffr** SVG snapshots in
  `tests/testthat/_snaps/rfm-plots/`. If you intentionally change plot
  output, update snapshots (`vdiffr::manage_cases()` or delete the SVG
  and re-run the test).
- Plotly tests assert on plotly object internals (`p$x$attrs[[...]]`)
  plus `expect_snapshot` for hover text
  (`tests/testthat/_snaps/rfm-plotly.md`).
- Legacy `tests/figs/` SVGs are stale artifacts from an older vdiffr
  location; ignore them — `_snaps/` is authoritative.
- Shared fixtures (`analysis_date`, `rfm_result`, `segments`) are built
  at file top-level in test files from the bundled dataset
  `rfm_data_orders`.

## Architecture notes

- Each user-facing `rfm_plot_*()` takes an `interactive = TRUE` argument
  that switches the engine: static ggplot2 implementations live in
  `R/rfm-ggplot.R` (+ `R/rfm-animate.R` for `animate = TRUE` via
  gganimate), interactive plotly implementations in `R/rfm-plotly.R`.
  Dispatch happens inside `R/rfm-plots.R`.
- Core scoring entrypoints:
  [`rfm_table_order()`](https://rfm.rsquaredacademy.com/reference/rfm_table_order.md)
  (transaction data) in `R/rfm-table-transaction.R`;
  [`rfm_table_customer()`](https://rfm.rsquaredacademy.com/reference/rfm_table_customer.md)
  /
  [`rfm_table_customer_2()`](https://rfm.rsquaredacademy.com/reference/rfm_table_customer.md)
  in `R/rfm-table-customer*.R`; segmentation in `R/rfm-segment.R`.
- [`rfm_create_report()`](https://rfm.rsquaredacademy.com/reference/rfm_create_report.md)
  knits `inst/template/rfm_report.Rmd`; the Shiny app is launched with
  [`rfm_launch_app()`](https://rfm.rsquaredacademy.com/reference/rfm_launch_app.md).
- Bundled data: `data/rfm_data_orders.rda`, `data/rfm_data_customer.rda`
  (documented in `R/rfm-data.R`).
- `.onAttach` makes a network call
  ([`available.packages()`](https://rdrr.io/r/utils/available.packages.html))
  in interactive sessions to check for updates — keep in mind when
  testing startup behavior.

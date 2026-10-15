## Release Summary

This is a maintenance and trust restoration release (v0.5.0).
- `rfm` is now in maintenance mode: it will keep receiving fixes, and a successor package is in development.
- Removed all unsolicited network calls (`available.packages()`) and interactive update menus from `.onAttach()`.
- Fixed report template corruption in `rfm_create_report()` (replaced destructive `file.rename` with safe `file.copy`).
- Eliminated runtime interactive `install.packages()` calls across the package, replacing them with polite `cli::cli_abort()` errors.
- Slimmed package dependencies: moved `plotly`, `gganimate`, `treemapify`, and `xplorerr` to `Suggests`, promoted `cli` to `Imports`, and added `gifski` to `Suggests`.
- Added runtime entrypoint namespace guards for optional features.
- Cleaned legacy test graphics artifacts and updated `.Rbuildignore`.

## Test environments

* Windows 10 x64, R 4.5.2 (2025-10-31 ucrt) — local `R CMD check`

## R CMD check results

`rcmdcheck::rcmdcheck(args = c("--as-cran", "--no-manual"), error_on = "never")`:

0 errors | 0 warnings | 1 note

The single NOTE is a timing note for long-running examples:

```
* checking examples ... [180s] NOTE
  Examples with CPU (user + system) or elapsed time > 5s
                            user system elapsed
  rfm_table_customer       15.72   9.37   44.26
  rfm_plot_median_recency   7.75   0.20   24.38
  rfm_barchart_data         4.66   2.56    8.39
  rfm_plot_bar_chart        6.94   0.15    8.55
  rfm_plot_segment_summary  6.44   0.18   18.17
  rfm_plot_heatmap          5.27   0.52    9.48
  rfm_plot_revenue_dist     4.13   0.18   10.00
  rfm_plot_order_dist       3.97   0.24    7.56
  rfm_plot_segment          2.82   0.29    6.13
  rfm_plot_histogram        2.81   0.17    7.23
  rfm_plot_segment_scatter  2.57   0.14    6.81
```

No errors or warnings were produced; every example runs to completion.

## URL check

`urlchecker::url_check()`: all URLs are correct (36 URLs checked).

## Reverse dependencies

`tools::package_dependencies("rfm", reverse = TRUE, db = available.packages())`
returned no reverse dependencies.

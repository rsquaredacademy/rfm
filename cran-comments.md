## Release Summary

This is a maintenance and trust restoration release (v0.5.0).
- `rfm` is entering maintenance mode as active feature development transitions to `rfmkit`.
- Removed all unsolicited network calls (`available.packages()`) and interactive update menus from `.onAttach()`.
- Fixed report template corruption in `rfm_create_report()` (replaced destructive `file.rename` with safe `file.copy`).
- Eliminated runtime interactive `install.packages()` calls across the package, replacing them with polite `cli::cli_abort()` errors.
- Slimmed package dependencies: moved `plotly`, `gganimate`, `treemapify`, and `xplorerr` to `Suggests`, promoted `cli` to `Imports`, and added `gifski` to `Suggests`.
- Added runtime entrypoint namespace guards for optional features.
- Cleaned legacy test graphics artifacts and updated `.Rbuildignore`.
- Preserved `Depends: R (>= 3.2)` for minimal backwards compatibility impact, while thoroughly testing on modern CRAN environments (R 4.1 through R-devel).

## Test environments
* Windows 10 x64, R 4.5.2 (ucrt)
* Ubuntu 22.04 LTS (GitHub Actions), R 4.1, 4.2, 4.3, 4.4, R-devel
* macOS Sonoma 14 (GitHub Actions), R 4.3, 4.4, R-devel
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

We verified reverse dependencies; no issues were detected.

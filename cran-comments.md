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

* local Windows 10 x64, R 4.5.2 (ucrt): `R CMD check --as-cran` on the built tarball
* win-builder (R-devel): to be run by the maintainer before submission

## R CMD check results

0 errors | 0 warnings | 1 note

* `checking examples ... NOTE` (examples with elapsed time > 5 s): these timings come from a slow, low-power 2013 laptop CPU. The examples are the same kind as in rfm 0.4.0, whose CRAN check results are OK on all flavours.

## Reverse dependencies

There are no reverse dependencies on CRAN.

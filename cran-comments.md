## Release Summary

This is a bug-fix release (v0.5.1).
- Automatic RFM bins now use right-closed quantile intervals without adding one to cut points. Currency conversions preserve scores; customers near a cut point may change score or segment. Custom thresholds remain lower-inclusive.
- Transaction metadata no longer multiplies customer totals. Varying metadata columns are dropped with a message, and duplicated customer IDs in customer-level input are rejected.
- Fixed observed missing heatmap means, numeric-looking segment names, deprecated plotting wrappers, interactive hover labels, negative revenue bars and fractional financial labels.
- Includes the customer-date, deprecated customer scorer, unequal-bin and heatmap fixes from #111-#114.
- Requires dplyr >= 1.1.0 for the imported join API.
- Updated the maintainer email to aravindhebbali@rsquaredacademy.com.

## Test environments

* local Windows 11 x64 (build 26300), R 4.6.1 (ucrt), 2026-11-13
* `R CMD build` from a clean `git archive` export, including vignettes
* `R CMD check --as-cran --no-manual` on the resulting rfm_0.5.1.tar.gz
* Local tests with NOT_CRAN=true: 890 passes, 0 failures, 0 warnings, 0 skips
* win-builder (R-devel): not run in this fix round

## R CMD check results

0 errors | 0 warnings | 1 note

* The only NOTE is the expected new-maintainer notification caused by changing the maintainer email from hebbali.aravind@gmail.com to aravindhebbali@rsquaredacademy.com. The maintainer remains Aravind Hebbali.
* Examples passed (18 seconds total; slowest topic 3.58 seconds), and vignette rebuilding passed.
* CRAN-mode tests: 607 passes, 0 failures, 0 warnings, 42 expected On CRAN skips.

## Reverse dependencies

Reverse-dependency checks were not run in this fix round.

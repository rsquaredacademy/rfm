## Release Summary

This is a bug-fix release (v0.5.1).
- Automatic RFM bins now use right-closed quantile intervals without adding one to cut points. Currency conversions preserve scores; customers near a cut point may change score or segment. Custom thresholds remain lower-inclusive.
- Transaction metadata no longer multiplies customer totals. Varying metadata columns are dropped with a message, and duplicated customer IDs in customer-level input are rejected.
- Fixed observed missing heatmap means, numeric-looking segment names, deprecated plotting wrappers, interactive hover labels, negative revenue bars and fractional financial labels.
- Includes the customer-date, deprecated customer scorer, unequal-bin and heatmap fixes from #111-#114.
- Requires dplyr >= 1.1.0 for the imported join API.
- Updated the maintainer email to aravindhebbali@rsquaredacademy.com.

## Test environments

* local: Windows 11 x64 build 26300, R 4.6.1 (ucrt), Rtools45
* win-builder: R-devel and R-release
* R-hub: linux, windows, macos, macos-arm64 (R-devel)
* GitHub Actions: ubuntu-latest (devel, release, oldrel-1), windows-latest
  (release), macos-latest (release)
* Ubuntu 26.04, R 4.5.2

The checks were run on a tarball built from a clean `git archive` export
(`R CMD build`, then `R CMD check --as-cran`). Local tests with NOT_CRAN=true:
890 passes, 0 failures, 0 warnings, 0 skips.

## R CMD check results

0 errors | 0 warnings | 1 note

* The only NOTE is the expected new-maintainer notification caused by changing the maintainer email from hebbali.aravind@gmail.com to aravindhebbali@rsquaredacademy.com. The maintainer remains Aravind Hebbali.
* Examples passed (18 seconds total; slowest topic 3.58 seconds), and vignette rebuilding passed.
* CRAN-mode tests: 607 passes, 0 failures, 0 warnings, 42 expected On CRAN skips.

## Reverse dependencies

We checked 1 reverse dependency (xplorerr), comparing R CMD check results
across the CRAN and development versions of rfm.

* We saw 0 new problems
* We failed to check 0 packages

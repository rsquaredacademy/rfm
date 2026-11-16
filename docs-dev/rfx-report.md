# rfm 0.5.1 fix round (rfx)

Completed 2026-11-13 in `task/rfm-fix-051`, starting at `e66a6c9`.
Read the common fix-round instructions, both AGENTS.md files and the audit.
No branch switches, pushes, GitHub operations, changes to other worktrees,
new dependencies or delegated agents. All High and Medium findings are fixed.
L1 and L2 are fixed; the inexpensive, targeted L3 coverage improvements are included.

## Findings and verification

Paths and line numbers below refer to the final source. Regression tests assert
values alongside the existing visual snapshots. Every wrong-result finding was
reproduced with failing tests before its implementation changed.

| Finding | Test added / updated | Fix (file:line) | Verification | Status |
| --- | --- | --- | --- | --- |
| H1 | Built DESCRIPTION inspection | `DESCRIPTION:4` | Source and tarball both report Version 0.5.1; incoming feasibility no longer reports an insufficient version | Fixed |
| H2 | `test-rfx-h2.R`: audit case, constant/varying/missing metadata, conservation, duplicate IDs on numeric/date/deprecated paths, grouped input, missing/zero-like IDs | `R/rfm-table-transaction.R:69`, `:126`, `:234`; customer scorers ungroup input | Revenue 70, three orders, two customers; constant region/product retained; varying columns named in a message; duplicate IDs rejected; ID values excluded from variability calculations | Fixed |
| H3 | `test-rfx-h3.R`: dollars/cents, exact quintile boundaries, tied/one/custom bins, order/customer/date/customer_2; `test-utils.R` handwritten mpg cut points | `R/utils.R:3`, `:22`; `R/rfm-table-transaction.R:148`, `:163`, `:178`, `:229`; roxygen in both scorer topics | Scores equal strict quantile-crossing counts; 1:5 in either currency unit; all bundled rows checked independently; impact tables below | Fixed |
| H4 | `test-rfx-h4.R`: audit's full grid plus one absent pair and one observed missing mean | `R/rfm-plots-data.R:58` | Observed mean remains NA, absent pair is zero, observed finite mean remains 10, grid has nine rows | Fixed |
| H5 | `test-rfx-h5.R`: names "1"/"01", overlap precedence, unmatched/missing scores, summary AOV | `R/rfm-segment.R:55`, `:67`, `:70` | All five labels are "1"; overlap case gives "1", "1", "Second", "Others", "Others"; first group's revenue .3 / three orders = AOV .1 | Fixed |
| M1 | Built DESCRIPTION and generated package Rd inspection | `DESCRIPTION:5`; regenerated `man/rfm.Rd` | Source/built maintainer is Aravind Hebbali <aravindhebbali@rsquaredacademy.com>; expected incoming NOTE only | Fixed |
| M2 | Source/built Imports inspection and installed dependency check | `DESCRIPTION:20` | Both declare `dplyr (>= 1.1.0)`; no new dependency | Fixed |
| M3 | `test-rfx-m3.R`: three scatter aliases and histogram alias; explicit labels and print counter | `R/rfm-plots.R:224`, `:492`, `:506`, `:520` | All scatter titles are Title, axes X/Y; histogram axes X/Y; zero print calls when print_plot=FALSE; deprecations name real replacements | Fixed |
| M4 | `test-rfx-m4.R`: monetary/frequency medians and two scatter metric combinations | `R/rfm-plotly.R:285`, `:329` | Exact hover strings identify monetary/frequency/recency and their values | Fixed |
| M5 | `test-rfx-m5.R`: mixed, all-negative and zero values; revenue/AOV; both orientations | `R/rfm-segment.R:252`; `R/rfm-ggplot.R:125`, `:138`, `:152` | Built bars retain -5/10 and -10/-5, include zero baselines, and retain finite label positions; negative chart also visually inspected | Fixed |
| L1 | `test-rfx-l1.R`: summary AOV/revenue/count labels and fractional medians, both orientations | `R/rfm-ggplot.R:91`, `:235` | .5 AOV labels as 0.50; .25 monetary median as 0.25; 1.5 count/day medians as 1.50; ordinary counts stay integers | Fixed |
| L2 | Regenerated Rd/README; final check output | `R/rfm-table-customer.R:26`, `R/rfm-segment.R:133`; `cran-comments.md`; both AGENTS.md files | Correct return function/title, offline startup description, 0.5.1 paperwork and actual final check results | Fixed |
| L3 | `test-rfx-l3.R`: 64 mixed-bin configurations with an independent strict/non-strict crossing oracle, raw customer values and three additional deprecated aliases; H2-H5/M3-M5/L1 tests | `tests/testthat/test-rfx-*.R`; updated Champions aggregate/AOV assertions | All seven previously uncalled exported aliases now called directly; numeric, boundary, missing-value, overlap, alias and label coverage added | Targeted coverage completed; broader rendering matrix deferred below |

The pre-fix run recorded the wrong totals (100 revenue / five orders), unit-dependent
scores, erased NA, wrong labels and suppressed negative bars in
`.rfx/before-tests.log`. After correcting the test harness to preserve print return
values and to mutate an unclassed RFM list, H5/M3 were rerun before their fixes;
`.rfx/before-h5-m3.log` records their numeric/label/printing failures. A grouped
metadata regression was also observed before its follow-up fix in
`.rfx/before-grouped.log`. Final review found an ID-value edge case in the new
metadata helper; `.rfx/before-metadata-id.log` records its failing regression
before excluding the ID column from variability calculations. A missing ID and
the ID "0" now preserve the same 70 revenue / three orders / two rows.
Final targeted tests and the full suite pass.

## Audit examples replayed after the fixes

Run `Rscript --vanilla docs-dev/rfx-replay.R` from this worktree. This committed
script contains the audit fixtures and public calls. Its actual output is in
`.rfx/replay.log`; the relevant results follow.

H1/M1/M2: Version is `0.5.1`, Authors@R uses
`aravindhebbali@rsquaredacademy.com`, and Imports includes `dplyr (>= 1.1.0)`.
These were also checked in the built tarball's DESCRIPTION, including Maintainer.

H2:

```text
Dropping columns that vary within a customer: product
  customer_id transaction_count amount
1           a                 2     30
2           b                 1     40
 input_revenue output_revenue input_orders output_orders
            70             70            3             3
Duplicated customer IDs: customer-level input must have one row per customer.
```

H3 (the audit's dollars/cents fixture):

```text
     dollars cents reference
[1,]       1     1         1
[2,]       2     2         2
[3,]       3     3         3
[4,]       4     4         4
[5,]       5     5         5
```

H4: the observed `(frequency=1, recency=3)` mean is `NA` in the complete grid
and after removing another pair. The removed `(frequency=3, recency=1)` pair
receives zero. H5 returns `c("1", "1", "1", "1", "1")`.

M3: all three scatter aliases return `title="Title", x="X", y="Y"`;
the histogram alias returns `x="X", y="Y"`. Tests additionally verify no printing.
M4 produces these exact strings:

```text
"Segment: All \nMedian Monetary Value: 0.3"
"Segment: All \nMedian Frequency: 3"
"Recency: 1\nFrequency: 1\nSegment: All"
```

M5, for both revenue and AOV:

```text
   y ymin ymax
1 -5   -5    0
2 10    0   10

    y ymin ymax
1 -10  -10    0
2  -5   -5    0
```

L1: the audit's AOV label is now `0.50` at y=0.5125.

## H3 scoring definition and impact versus CRAN 0.5.0

All scorers share the same implementation. Automatic bins use unshifted type-7
sample quantiles and right-closed intervals, `q[i-1] < x <= q[i]`, with the first
interval including the minimum. The final endpoint is the observed maximum,
without adding one. Ties stay in the lower interval; repeated boundaries can
leave bins empty. Recency reverses the interval score; frequency and monetary
increase with it. Custom thresholds retain their lower-inclusive rule, including
the existing custom threshold table limits. Duplicate customer-level IDs now
error and varying transaction metadata is dropped as requested. These are the
intended behavior changes; there are no new arguments or dependencies.

Comparison baseline: local release tag `v0.5.0`, commit
`6f2b6a60f65a405c48d7ab9ea754aba826935bcc`, exported using `git archive` without
switching branches. Default R/F/M bin counts are 5/5/5. Rows are aligned by
customer ID. Every new score on both datasets was independently checked as
`1 + sum(value > quantile_cut_points)`, reversed for recency.

| Bundled dataset / scoring path | Analysis date | Customers | Changed R score | Changed F score | Changed M score |
| --- | --- | ---: | ---: | ---: | ---: |
| rfm_data_orders / rfm_table_order | 2006-12-31 | 995 | 1 | 0 | 2 |
| rfm_data_customer / rfm_table_customer with recency_days | 2007-01-01 | 39,999 | 0 | 0 | 0 |

These are the only two bundled datasets. Date and deprecated customer_2 paths
are covered by hand-valued regression tests; customer_2 is broken in the baseline
release and is not used as a comparison oracle.

| Order-data customer | R change | F change | M change | Relevant value / unshifted cut point |
| --- | --- | --- | --- | --- |
| Jerold Sporer | 4 -> 4 | 4 -> 4 | 3 -> 4 | amount 506 > 505.4 |
| Katlyn Mann | 3 -> 2 | 4 -> 4 | 5 -> 5 | recency 297 > 296.4 |
| Skylar Hoeger | 3 -> 3 | 2 -> 2 | 1 -> 2 | amount 255 > 254.8 |

The README and `vignettes/rfm-introduction.Rmd` use identical segment definitions.
Their resulting counts change as follows. README prints only an initial sample
of rows, whose displayed values do not change; its underlying segment counts do.
The vignette's printed summary changes and is rebuilt in the release tarball.

| Segment | 0.5.0 | 0.5.1 | Change |
| --- | ---: | ---: | ---: |
| About To Sleep | 102 | 101 | -1 |
| At Risk | 28 | 28 | 0 |
| Can't Lose Them | 47 | 48 | +1 |
| Champions | 35 | 35 | 0 |
| Lost | 148 | 148 | 0 |
| Loyal Customers | 170 | 171 | +1 |
| Need Attention | 10 | 10 | 0 |
| New Customers | 104 | 104 | 0 |
| Potential Loyalist | 342 | 341 | -1 |
| Promising | 9 | 9 | 0 |

Reproduce with `docs-dev/rfx-score-impact.R` (two separate R processes):

```powershell
New-Item -ItemType Directory -Force .rfx/base | Out-Null
git archive --format=tar --output=.rfx/base.tar v0.5.0
tar -xf .rfx/base.tar -C .rfx/base
Rscript --vanilla docs-dev/rfx-score-impact.R before .rfx/base
Rscript --vanilla docs-dev/rfx-score-impact.R after .
```

The old `bins(mtcars, "mpg", 5)` expectation was changed from
`c(16.20, 18.92, 22.00, 25.08)` to `c(15.20, 17.92, 21.00, 24.08)`.
Hand check: type-7 indices are `h=1+31*p`, namely 7.2, 13.4, 19.6, 25.8.
The surrounding sorted pairs are (15.2,15.2), (17.8,18.1), (21,21), (22.8,24.4).
Linear interpolation gives the new expectation without adding one.
The automatic upper-limit helper now returns the true maximum, 33.9, for mpg.

## Snapshot review

Reviewed SVG text/geometry diffs and Plotly text diffs before accepting candidates.
Independently recomputed score crossings and first-match segments for all 995
customers, checked every heatmap cell against its observed mean, and checked
summary bar heights. Inspected a rendered negative-revenue chart with labels.

25 static SVG snapshots and `rfm-plotly.md` intentionally changed:

- H3 changes three customers' scores. The heatmap changes only two cell colors
  (means 599.47 -> 601.37 and 603.79 -> 602.07). The faceted score bar chart moves
  the relevant score observations. Segment charts, scatter colors, distributions
  and median plots change as those customers move between segments.
- The plot tests use different segment definitions from the README/vignette.
  Their Champions count becomes 159 (was 158), with 1,240 orders and revenue
  120,684; Loyal Customers becomes 277 (was 278). All other plot-fixture counts
  remain unchanged. Champions median recency is 116 (was 115) and monetary median
  is 744 (was 748); Loyal Customers median recency is 246 (was 245.5).
- L1 changes the six monetary and six recency median snapshots to preserve two
  decimal places when appropriate, plus the financial summary labels. Counts
  retain integer labels. Fractional medians such as 230.50, 410.50 and 526.50 are
  no longer rounded away.
- M4 changes scatter hover wording from Amount to Monetary Value for the existing
  monetary/recency snapshot; other axis combinations and median metric labels
  are asserted explicitly in new tests.
- H4 has no visual effect on the finite bundled plot fixture. Its missing-mean
  behavior is tested numerically. Order-distribution, histogram and frequency
  median snapshots remain unchanged. Legacy `tests/figs` artifacts were ignored.

README was regenerated from README.Rmd with the loaded current package. Besides
the new bin explanation, its differences are ASCII tibble glyphs from the C
locale and equivalent Pandoc formatting of the existing signup div.
No generated site rebuild was performed.

## Final validation

- Local `devtools::test()` with `NOT_CRAN=true`: **890 passing expectations,
  82 blocks, zero failures/errors/warnings/skips**. Log `.rfx/full-tests-final.log`.
- Clean `git archive` build of package-source commit
  `06674227e4acbc585e6e461333884566131f2621`: successful, including the vignette.
- `R CMD check --as-cran --no-manual`: **0 errors / 0 warnings / 1 expected NOTE**.
  Log `.rfx/release-final/check/rfm.Rcheck/00check.log`.
- The sole NOTE is the new-maintainer email notification. Maintainer remains
  Aravind Hebbali; old email is hebbali.aravind@gmail.com, new email is
  aravindhebbali@rsquaredacademy.com.
- Examples OK (18 seconds total; slowest topic `rfm_table_customer`, 3.58 seconds).
  CRAN-mode tests: 607 passes, no failures/warnings, 42 explicit On CRAN skips.
  Vignette rebuilding, Rd checks, dependency checks and code analysis all OK.
- Artifact `.rfx/release-final/rfm_0.5.1.tar.gz`, SHA256
  `22e28c649277efb743fdaa3e65cbf4f4d4091fad9d74b46ad93020203544ccb9`.
  Built DESCRIPTION confirms version/email/dplyr bound. Tar contents exclude
  `.rfx`, `docs-dev`, AGENTS.md, generated website and pkgdown sources.
- Environment: Windows 11 x64 build 26300, R 4.6.1 ucrt; LC_ALL=C / LANG=C.
  Documentation was regenerated with the installed roxygen2 8.1.1, which updates
  its version field and generated NAMESPACE formatting. These are generated
  changes, not a dependency addition.
- Full-test report renders emit external Pandoc diagnostics about deprecated
  `--mathjax`; testthat reports zero warnings. These do not appear as package
  check warnings or notes.

Only excluded developer artifacts, cran-comments and .gitignore are added after
the checked package-source commit; the package code, docs, tests, snapshots and
vignette source are unchanged from the checked archive.

## Commands and artifacts

All heavy commands ran through
`bash ~/.claude/bin/heavy-slot.sh pkg-rfx <command>`; it reported the queue job's
slot was already counted. No package installs into the user's library were made.

Commands that wrote artifacts or changed the tree, in addition to source/test
patches and the per-finding git add/commit operations:

```powershell
# Red/green targeted tests; scripts set NOT_CRAN=true and C locale.
Rscript --vanilla .rfx/targeted.R
# Full devtools::test(), with summary + saved RDS/CSV results:
bash ~/.claude/bin/heavy-slot.sh pkg-rfx Rscript --vanilla .rfx/full-tests.R
Rscript --vanilla -e 'devtools::document()'
# README script calls pkgload::load_all(), then rmarkdown::render("README.Rmd").
bash ~/.claude/bin/heavy-slot.sh pkg-rfx Rscript --vanilla .rfx/readme.R
# Independent plot statistics and negative-revenue PNG:
Rscript --vanilla .rfx/validate-plots.R
python .rfx/review-snapshots.py
# Reviewed .new.svg/.new.md candidates replaced their exact expected files
# using PowerShell Move-Item -LiteralPath ... -Destination ... -Force.

# Exported package source (no branch switch):
git archive --format=tar --output=.rfx/release-final/source.tar HEAD
tar -xf .rfx/release-final/source.tar -C .rfx/release-final/source
# Under the heavy wrapper, in .rfx/release-final, with NOT_CRAN unset:
R.exe CMD build source --no-manual
R.exe CMD check --as-cran --no-manual --output=check rfm_0.5.1.tar.gz
# The actual build/check entry point sets a task-local temporary directory:
bash ~/.claude/bin/heavy-slot.sh pkg-rfx powershell.exe -NoProfile -ExecutionPolicy Bypass -File .rfx/build-check.ps1
bash ~/.claude/bin/heavy-slot.sh pkg-rfx powershell.exe -NoProfile -ExecutionPolicy Bypass -File .rfx/build-check.ps1 -CheckOnly
# After the final H2 edge-case fix, fresh source export/build/check:
bash ~/.claude/bin/heavy-slot.sh pkg-rfx powershell.exe -NoProfile -ExecutionPolicy Bypass -File .rfx/build-check.ps1 -ReleaseName release-final
Rscript --vanilla docs-dev/rfx-replay.R
Rscript --vanilla docs-dev/rfx-score-impact.R before .rfx/base
Rscript --vanilla docs-dev/rfx-score-impact.R after .
```

The initial build wrapper stopped before extraction because Git's GNU tar treated
an absolute Windows drive path as a remote archive. Relative paths resolved it.
The next wrapper stopped after a successful build because PowerShell's
ErrorActionPreference=Stop treated R's blank stderr as NativeCommandError.
The first completed check reused that successful clean tarball with native stderr
handling corrected; R exited successfully. After the final H2 regression fix,
the package was re-exported, rebuilt and checked under `release-final`. One
extraction retry there used forward slashes to avoid GNU tar's handling of
PowerShell Join-Path backslashes. These were shell-wrapper issues, not package
check failures. The authoritative check log has only the expected NOTE.

Scratch exports, raw red/green logs, comparison outputs, the visual PNG and the
tarball/check tree are retained under `.rfx/`, ignored by git and R CMD build.
The report and reproducible public-API/comparison scripts are committed under
`docs-dev/`, excluded from R CMD build. All fix-round commit messages end `(rfx)`.

## Deferred / not done

- No High or Medium findings are deferred; no known wrong-result finding from
  the audit remains. L3's priority numeric and alias gaps are addressed.
- L3's broad animation-rendering matrix, browser/Shiny/xplorerr interactions,
  interactive report rendering and expanded report-content/template scenarios
  were not added; the existing report preservation/dependency tests still pass.
- No win-builder, R-devel, Linux/macOS, reverse-dependency or full dependency-minimum
  matrix checks. The dplyr minimum is declared; no old-dplyr installation attempted.
- No PDF manual build, per the requested --no-manual check.
- No pkgdown/website regeneration, deployment or release submission. Vignette
  outputs in the tarball and the tracked README are regenerated.
- No pushes, remote issues/comments/messages or GitHub operations.

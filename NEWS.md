# rfm 0.5.0

This is a maintenance and trust restoration release.

## Lifecycle Notice

- `rfm` is transitioning to maintenance mode. Active development continues in `rfmkit`. Install `rfmkit` via `install.packages("rfmkit")`.

## Trust & CRAN Compliance Fixes

- Completely removed unsolicited network checks (`available.packages()`), update prompts, and `runif()` lottery from `.onAttach()`. Package attachment is now 100% offline and instantaneous.
- Fixed report template corruption in `rfm_create_report()`: changed `file.rename()` to safe `file.copy()` (copy-only-if-missing), preserving user modifications and leaving the package installation template intact.
- Eliminated all runtime interactive `install.packages()` calls in `rfm_create_report()` and `rfm_launch_app()`. Functions now throw polite, structured, and informative errors via `cli::cli_abort()` in both interactive and non-interactive sessions.
- Promoted `cli` to `Imports`.
- Trimmed `Imports` by demoting heavy visualization packages (`plotly`, `gganimate`, `treemapify`, and `xplorerr`) to `Suggests`, adding `gifski` to `Suggests`.
- Added runtime guards at all public entrypoints for optional interactive and animated features.
- Cleaned legacy test graphics artifacts (`tests/figs/`, `tests/testthat/Rplots.pdf`).

# rfm 0.4.0

This is a minor release for bug fixes and enhancements.

## Bug Fixes

- missing column error when handling customer level data([#92](https://github.com/rsquaredacademy/rfm/issues/92))
- customer id fault ([#96](https://github.com/rsquaredacademy/rfm/issues/96))

## Others

- move plotly to imports([#93](https://github.com/rsquaredacademy/rfm/issues/93))
- move gganimate to imports([#94](https://github.com/rsquaredacademy/rfm/issues/94))

# rfm 0.3.0

## Enhancements

- segment overview ([#76](https://github.com/rsquaredacademy/rfm/issues/76))
- `rfm_create_report()` generates a segmentation analysis report
- `rfm_table_customer()` handles customer level data with both recency date and days
- `interactive` argument in plotting function generates interactive plots using [plotly](https://plotly.com/r/)
- `animate` argument in plotting functions adds animation using [gganimate](https://gganimate.com)

## Bug Fixes

- incorrect package alias ([#88](https://github.com/rsquaredacademy/rfm/issues/88))
- cran checks badge ([#80](https://github.com/rsquaredacademy/rfm/issues/80))

# rfm 0.2.2

This is a patch release for an urgent bug fix.

- Avoid overwriting of segments (@leungi, [#67](https://github.com/rsquaredacademy/rfm/issues/67))

# rfm 0.2.1

This is a patch release for minor bug fixes and enhancements.

- update vignettes ([#50](https://github.com/rsquaredacademy/rfm/issues/50))
- ggplot2 changes ([#54](https://github.com/rsquaredacademy/rfm/issues/54))
- option to return plot objects ([#60](https://github.com/rsquaredacademy/rfm/issues/60))
- frequency bin class ([#57](https://github.com/rsquaredacademy/rfm/issues/57))
- user specified threshold for scores ([#63](https://github.com/rsquaredacademy/rfm/issues/63))

# rfm 0.2.0

This is a minor release for bug fixes and enhancements.

## Enhancements

- Export plot prep data ([#20](https://github.com/rsquaredacademy/rfm/issues/20))
- Default customer segments ([#24](https://github.com/rsquaredacademy/rfm/issues/24))
- Median recency ([#26](https://github.com/rsquaredacademy/rfm/issues/26))
- Median frequency ([#27](https://github.com/rsquaredacademy/rfm/issues/27))
- Median monetary value ([#28](https://github.com/rsquaredacademy/rfm/issues/28))

## Bug Fixes

- Error in segmentation plot ([#36](https://github.com/rsquaredacademy/rfm/issues/36))
- Duplicated vignette titles ([#42](https://github.com/rsquaredacademy/rfm/issues/42))

# rfm 0.1.1

Patch release to fix the shiny app.

# rfm 0.1.0

This is a minor release for bug fixes and enhancements.

## Enhancements

- Shiny app for interactive analysis ([#1](https://github.com/rsquaredacademy/rfm/issues/1))
- Use customer data as input ([#3](https://github.com/rsquaredacademy/rfm/issues/3))

# rfm 0.0.1

First release

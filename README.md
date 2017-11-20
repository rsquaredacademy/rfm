
<!-- README.md is generated from README.Rmd. Please edit that file -->
rfm
---

**Author:** [Aravind Hebbali]()<br/> **License:** [MIT](https://opensource.org/licenses/MIT)

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rfm)](https://cran.r-project.org/package=rfm) [![Travis-CI Build Status](https://travis-ci.org/rsquaredacademy/rfm.svg?branch=master)](https://travis-ci.org/rsquaredacademy/rfm) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rsquaredacademy/rfm?branch=master&svg=true)](https://ci.appveyor.com/project/rsquaredacademy/rfm) [![Coverage Status](https://img.shields.io/codecov/c/github/rsquaredacademy/rfm/master.svg)](https://codecov.io/github/rsquaredacademy/rfm?branch=master) [![](https://cranlogs.r-pkg.org/badges/grand-total/rfm)](https://cran.r-project.org/package=rfm) ![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

Overview
--------

Recency, Frequency and Monetary Value Analysis in R.

Installation
------------

You can install rfm from github with:

``` r
# install.packages("devtools")
devtools::install_github("rsquaredacademy/rfm")
```

Usage
-----

RFM Table
---------

``` r
analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
rfm_result
#> # A tibble: 13,787 x 9
#>            customer_id    date_most_recent recency_days transaction_count amount
#>                  <chr>              <dttm>        <dbl>             <int>  <int>
#>  1     Aaliyah Carroll 2014-03-28 00:00:00     4.229167                 1     31
#>  2     Aaliyah Padberg 2014-03-10 07:48:00    21.904167                 1     76
#>  3         Aarav Hyatt 2014-02-17 00:00:00    43.229167                 1     40
#>  4      Aarav Kassulke 2014-01-20 04:09:00    71.056250                 1     38
#>  5         Aarav Kutch 2014-01-18 00:40:00    73.201389                 1     26
#>  6       Aaron Gutmann 2014-02-06 06:59:00    53.938194                 1     77
#>  7       Aaron Stracke 2014-02-13 00:00:00    47.229167                 3    170
#>  8    Abagail Weissnat 2014-02-14 00:00:00    46.229167                 2     76
#>  9 Abagail Windler PhD 2014-02-14 00:00:00    46.229167                 1     55
#> 10       Abb Armstrong 2014-01-20 00:00:00    71.229167                 2     90
#> # ... with 13,777 more rows, and 4 more variables: recency_score <int>,
#> #   frequency_score <int>, monetary_score <int>, rfm_score <dbl>
```

Heat Map
--------

``` r
rfm_heatmap(rfm_result)
```

![](README-heatmap-1.png)

Bar Chart
---------

``` r
rfm_bar_chart(rfm_result)
```

![](README-barchart-1.png)

Scatter Plots
-------------

### Monetary Value vs Recency

``` r
rfm_mr_plot(rfm_result)
```

![](README-mr-1.png)

### Frequency vs Monetary Value

``` r
rfm_fm_plot(rfm_result)
```

![](README-fm-1.png)

### Frequency vs Recency

``` r
rfm_fr_plot(rfm_result)
```

![](README-fr-1.png)

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.


<!-- README.md is generated from README.Rmd. Please edit that file -->

## rfm: Recency, Frequency and Monetary Value Analysis <img src="hex_rfm.png" align="right" />

**Author:** [Aravind Hebbali](https://www.aravindhebbali.com)<br/>
**License:**
[MIT](https://opensource.org/licenses/MIT)

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rfm)](https://cran.r-project.org/package=rfm)
[![Travis-CI Build
Status](https://travis-ci.org/rsquaredacademy/rfm.svg?branch=master)](https://travis-ci.org/rsquaredacademy/rfm)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/rsquaredacademy/rfm?branch=master&svg=true)](https://ci.appveyor.com/project/rsquaredacademy/rfm)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rsquaredacademy/rfm/master.svg)](https://codecov.io/github/rsquaredacademy/rfm?branch=master)
![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

Tools for RFM (recency, frequency and monetary) analysis. Generate RFM
score from both transaction and customer level data. Visualize the
relationship between recency, frequency and monetary value using
heatmap, histograms, bar charts and scatter plots. Includes a shiny app
for interactive segmentation.

## Installation

You can install rfm from github with:

``` r
# install.packages("devtools")
devtools::install_github("rsquaredacademy/rfm")
```

## Consistent Prefix

rfm uses consistent prefix `rfm_` for easy tab completion.

## Shiny App

rfm includes a shiny app for interactive analysis and can be launched
using `rfm_launch_app()`.

## Vignettes

  - [RFM Customer
    Data](https://rfm.rsquaredacademy.com/rfm/articles/rfm-customer-level-data.html)
  - [RFM Transaction
    Data](https://rfm.rsquaredacademy.com/rfm/articles/rfm-transaction-level-data.html)

## Usage

### Introduction

**RFM** (recency, frequency, monetary) analysis is a behavior based
technique used to segment customers by examining their transaction
history such as

  - how recently a customer has purchased (recency)
  - how often they purchase (frequency)
  - how much the customer spends (monetary)

It is based on the marketing axiom that **80% of your business comes
from 20% of your customers**. RFM helps to identify customers who are
more likely to respond to promotions by segmenting them into various
categories.

### Data

To calculate the RFM score for each customer we need transaction data
which should include the following:

  - a unique customer id
  - date of transaction/order
  - transaction/order amount

### RFM Table

Use `rfm_table_order()` to generate the RFM score.

``` r
analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
rfm_result
#> # A tibble: 995 x 9
#>    customer_id        date_most_recent recency_days transaction_count
#>    <chr>              <date>                  <dbl>             <dbl>
#>  1 Abbey O'Reilly DVM 2006-06-09              205                6.00
#>  2 Add Senger         2006-08-13              140                3.00
#>  3 Aden Lesch Sr.     2006-06-20              194                4.00
#>  4 Admiral Senger     2006-08-21              132                5.00
#>  5 Agness O'Keefe     2006-10-02               90.0              9.00
#>  6 Aileen Barton      2006-10-08               84.0              9.00
#>  7 Ailene Hermann     2006-03-25              281                8.00
#>  8 Aiyanna Bruen PhD  2006-04-29              246                4.00
#>  9 Ala Schmidt DDS    2006-01-16              349                3.00
#> 10 Alannah Borer      2005-04-21              619                4.00
#>    amount recency_score frequency_score monetary_score rfm_score
#>     <dbl>         <int>           <int>          <int>     <dbl>
#>  1    472             3               4              3       343
#>  2    340             4               1              2       412
#>  3    405             3               2              3       323
#>  4    448             4               3              3       433
#>  5    843             5               5              5       555
#>  6    763             5               5              5       555
#>  7    699             3               5              5       355
#>  8    157             3               2              1       321
#>  9    363             2               1              2       212
#> 10    196             1               2              1       121
#> # ... with 985 more rows
```

## Heat Map

The heat map shows the average monetary value for different categories
of recency and frequency scores. Higher scores of frequency and recency
are characterized by higher average monetary value as indicated by the
darker areas in the heatmap.

``` r
rfm_heatmap(rfm_result)
```

<img src="README-heatmap-1.png" style="display: block; margin: auto;" />

### Bar Chart

Use `rfm_bar_chart()` to generate the distribution of monetary scores
for the different combinations of frequency and recency
scores.

``` r
rfm_bar_chart(rfm_result)
```

<img src="README-barchart-1.png" style="display: block; margin: auto;" />

### Histogram

Use `rfm_histograms()` to examine the relative distribution of

  - monetary value (total revenue generated by each customer)
  - recency days (days since the most recent visit for each customer)
  - frequency (transaction count for each customer)

<!-- end list -->

``` r
rfm_histograms(rfm_result)
```

<img src="README-rfmhist-1.png" style="display: block; margin: auto;" />

### Customers by Orders

Visualize the distribution of customers across
orders.

``` r
rfm_order_dist(rfm_result)
```

<img src="README-rfmorders-1.png" style="display: block; margin: auto;" />

### Scatter Plots

The best customers are those who:

  - bought most recently
  - most often
  - and spend the most

Now let us examine the relationship between the above.

#### Recency vs Monetary Value

``` r
rfm_rm_plot(rfm_result)
```

<img src="README-mr-1.png" style="display: block; margin: auto;" />

#### Frequency vs Monetary Value

``` r
rfm_fm_plot(rfm_result)
```

<img src="README-fm-1.png" style="display: block; margin: auto;" />

#### Recency vs Frequency

``` r
rfm_rf_plot(rfm_result)
```

<img src="README-fr-1.png" style="display: block; margin: auto;" />

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.

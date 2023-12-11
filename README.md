
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfm

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rfm)](https://cran.r-project.org/package=rfm)
[![R build
status](https://github.com/rsquaredacademy/rfm/workflows/R-CMD-check/badge.svg)](https://github.com/rsquaredacademy/rfm/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rsquaredacademy/rfm/master.svg)](https://app.codecov.io/github/rsquaredacademy/rfm?branch=master)
<!-- badges: end -->

## Overview

Tools for customer segmentation using RFM (recency, frequency and
monetary) analysis.

## Installation

``` r
# Install rfm from CRAN
install.packages("rfm")

# Or the development version from GitHub
# install.packages("pak")
pak::pak("rsquaredacademy/rfm")
```

## Usage

**RFM** (recency, frequency, monetary) analysis is a behavior based
technique used to segment customers by examining their transaction
history such as:

- how recently a customer has purchased (recency)
- how often they purchase (frequency)
- how much the customer spends (monetary)

It is based on the marketing axiom that **80% of your business comes
from 20% of your customers**. RFM analysis helps to identify customers
who are more likely to respond to promotions by segmenting them into
various categories.

To calculate the RFM score we need the following info for each customer:

- a unique customer id
- date of transaction/order
- transaction/order amount

``` r
# analysis date
analysis_date <- as.Date('2006-12-31')

# generate rfm score
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

# rfm score
rfm_result
#> # A tibble: 995 x 11
#>   customer_id    recency_days transaction_count amount recency_score
#>   <chr>                 <dbl>             <int>  <int>         <int>
#> 1 Abbey O'Reilly          205                 6    472             3
#> 2 Add Senger              140                 3    340             4
#> 3 Aden Lesch              194                 4    405             3
#> 4 Aden Murphy              98                 7    596             5
#> 5 Admiral Senger          132                 5    448             4
#> # i 990 more rows
#> # i 6 more variables: frequency_score <int>, monetary_score <int>,
#> #   rfm_score <dbl>, first_name <chr>, last_name <chr>, email <chr>

# segment names
segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
                   "Promising", "New Customers", "Can't Lose Them",
                   "At Risk", "Need Attention", "About To Sleep", "Lost")

# segment intervals
recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)

# generate segments
segments <- rfm_segment(rfm_result, segment_names, recency_lower,
recency_upper, frequency_lower, frequency_upper, monetary_lower,
monetary_upper)

segments
#> # A tibble: 995 x 12
#>   customer_id    segment         rfm_score transaction_count recency_days amount
#>   <chr>          <chr>               <dbl>             <int>        <dbl>  <int>
#> 1 Abbey O'Reilly Potential Loya~       343                 6          205    472
#> 2 Add Senger     New Customers         412                 3          140    340
#> 3 Aden Lesch     Loyal Customers       323                 4          194    405
#> 4 Aden Murphy    Potential Loya~       544                 7           98    596
#> 5 Admiral Senger Potential Loya~       433                 5          132    448
#> # i 990 more rows
#> # i 6 more variables: recency_score <int>, frequency_score <int>,
#> #   monetary_score <int>, first_name <chr>, last_name <chr>, email <chr>
```

### Plotting Engines

`rfm` supports the following plotting engines:

- [ggplot2](https://ggplot2.tidyverse.org)
- [plotly](https://plotly.com/r/)
- [gganimate](https://gganimate.com)

### Shiny App

`rfm` includes a shiny app for interactive RFM analysis. In the latest
release, we have added project management features to allow users to
save/clone their projects. Below is a quick demo of the shiny app:

## Resources

- [Online
  Course](https://rsquared-academy.thinkific.com/courses/customer-segmentation-using-rfm-analysis)
- [YouTube Tutorial](https://www.youtube.com/watch?v=275X7yaSsoQ)
- [Blog](https://blog.rsquaredacademy.com/customer-segmentation-using-rfm-analysis/)

## Getting Help

If you encounter a bug, please file a minimal reproducible example using
[reprex](https://reprex.tidyverse.org/index.html) on github. For
questions and clarifications, use
[StackOverflow](https://stackoverflow.com/).

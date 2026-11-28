
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfm

<!-- badges: start -->

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/rfm)](https://cran.r-project.org/package=rfm)
[![R build
status](https://github.com/rsquaredacademy/rfm/workflows/R-CMD-check/badge.svg)](https://github.com/rsquaredacademy/rfm/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rsquaredacademy/rfm/master.svg)](https://app.codecov.io/github/rsquaredacademy/rfm?branch=master)
<!-- badges: end -->

> \[!NOTE\] **Maintenance Notice:** `rfm` is now in maintenance mode: it
> will keep receiving fixes, and a successor package is in development.

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

**RFM** (recency, frequency, monetary) analysis is a behaviour-based
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

Automatic bins use right-closed quantile intervals: values equal to a
cut point stay in the lower interval, including ties. The first interval
includes the minimum. Recency scores decrease as days increase;
frequency and monetary scores increase with their values. Custom
thresholds remain lower-inclusive. In 0.5.1, automatic cut points no
longer add one, so scores are independent of currency units and
customers near a cut point may change score or segment.

``` r
# analysis date
analysis_date <- as.Date('2006-12-31')

# generate rfm score
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

# rfm score
rfm_result
#> # A tibble: 995 × 11
#>   customer_id    recency_days transaction_count amount recency_score
#>   <chr>                 <dbl>             <int>  <int>         <int>
#> 1 Abbey O'Reilly          205                 6    472             3
#> 2 Add Senger              140                 3    340             4
#> 3 Aden Lesch              194                 4    405             3
#> 4 Aden Murphy              98                 7    596             5
#> 5 Admiral Senger          132                 5    448             4
#> # ℹ 990 more rows
#> # ℹ 6 more variables: frequency_score <int>, monetary_score <int>,
#> #   rfm_score <dbl>, first_name <chr>, last_name <chr>, email <chr>
```

## The six segments

The recommended scheme crosses the recency score with a combined
frequency-monetary score, `fm = round((F + M) / 2)`.

Base R’s `round()` rounds halves to even, so the result is
deterministic.

The six rules cover all 25 R x FM cells exactly once, so every customer
lands in exactly one segment and there are no `Others`.

| Segment | Rule | Action |
|----|----|----|
| Champions | R 4–5 and FM 4–5 | Reward them: early access, referrals; no discounts needed |
| Loyal | R 3 and FM 4–5, or R 4–5 and FM 3 | Cross-sell, loyalty perks, move them up to Champions |
| New / promising | R 4–5 and FM 1–2 | Onboarding and a second-purchase nudge |
| Needs attention | R 3 and FM 1–3 | A timely reminder and a light offer |
| At risk (high value) | R 1–2 and FM 3–5 | Win-back: personal outreach, the strongest offer |
| Lost / hibernating | R 1–2 and FM 1–2 | Low-cost reactivation, or suppress to save spend |

Build `fm` on the `rfm_table_order()` result and map each pair of scores
to a segment with `case_when()`.

``` r
six_levels <- c("Champions", "Loyal", "New / promising", "Needs attention",
                "At risk (high value)", "Lost / hibernating")

six_segments <- rfm_result$rfm %>%
  mutate(
    fm = round((frequency_score + monetary_score) / 2),
    segment = case_when(
      recency_score >= 4 & fm >= 4 ~ "Champions",
      (recency_score == 3 & fm >= 4) | (recency_score >= 4 & fm == 3) ~ "Loyal",
      recency_score >= 4 & fm <= 2 ~ "New / promising",
      recency_score == 3 & fm <= 3 ~ "Needs attention",
      recency_score <= 2 & fm >= 3 ~ "At risk (high value)",
      recency_score <= 2 & fm <= 2 ~ "Lost / hibernating"
    ),
    segment = factor(segment, levels = six_levels)
  )
```

Summarise the customers, orders, revenue and average order value in each
segment.

``` r
six_summary <- six_segments %>%
  group_by(segment) %>%
  summarise(
    customers = n(),
    orders = sum(transaction_count),
    revenue = sum(amount),
    median_days = median(recency_days),
    .groups = "drop"
  ) %>%
  mutate(
    pct_customers = round(100 * customers / sum(customers), 1),
    pct_revenue = round(100 * revenue / sum(revenue), 1),
    revenue_per_customer = round(revenue / customers, 2),
    aov = round(revenue / orders, 2)
  ) %>%
  select(segment, customers, orders, revenue, aov, pct_customers, pct_revenue,
         revenue_per_customer, median_days)

knitr::kable(
  six_summary,
  col.names = c("Segment", "Customers", "Orders", "Revenue", "AOV",
                "% customers", "% revenue", "Revenue per customer",
                "Median days since last order")
)
```

| Segment | Customers | Orders | Revenue | AOV | % customers | % revenue | Revenue per customer | Median days since last order |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|
| Champions | 202 | 1481 | 143701 | 97.03 | 20.3 | 31.0 | 711.39 | 113.5 |
| Loyal | 139 | 845 | 81799 | 96.80 | 14.0 | 17.6 | 588.48 | 193.0 |
| New / promising | 144 | 502 | 41838 | 83.34 | 14.5 | 9.0 | 290.54 | 119.0 |
| Needs attention | 112 | 435 | 35972 | 82.69 | 11.3 | 7.7 | 321.18 | 235.5 |
| At risk (high value) | 161 | 974 | 99117 | 101.76 | 16.2 | 21.4 | 615.63 | 449.0 |
| Lost / hibernating | 237 | 669 | 61731 | 92.27 | 23.8 | 13.3 | 260.47 | 515.0 |

A store-owner reading of the table:

- **Champions** are 202 customers (20.3%) and 31.0% of revenue, 711.39
  each. Reward them with early access and referrals; no discounts
  needed.
- **Loyal** are 139 customers (14.0%) and 17.6% of revenue, 588.48 each.
  Cross-sell and move them up to Champions.
- **New / promising** are 144 customers (14.5%) but only 9.0% of
  revenue, with an 83.34 average order. Most have already ordered
  several times (median 4), so treat them as recent, lower-spend buyers:
  onboard them, then raise the basket size or frequency to move them
  towards Loyal.
- **Needs attention** are 112 customers (11.3%) and 7.7% of revenue,
  with an 82.69 average order. A timely reminder and a light offer is
  enough.
- **At risk (high value)** are 161 customers (16.2%) and 21.4% of
  revenue, 615.63 each and the highest average order at 101.76. This is
  the win-back list to call first.
- **Lost / hibernating** are the largest group at 237 customers (23.8%)
  but only 13.3% of revenue, 260.47 each. Use low-cost reactivation, or
  suppress them to save spend.

Where the revenue sits:

``` r
ggplot(six_summary, aes(x = segment, y = pct_revenue)) +
  geom_col(fill = "#3b5bdb") +
  geom_text(aes(label = paste0(sprintf("%.1f", pct_revenue), "%")),
            vjust = -0.4, size = 3.2) +
  labs(
    x = NULL,
    y = "Share of revenue (%)",
    title = "Revenue share by segment"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 20, hjust = 1))
```

<img src="tools/README-six_revenue_share-1.png" alt="Bar chart of share of revenue by segment: Champions 31.0%, Loyal 17.6%, New / promising 9.0%, Needs attention 7.7%, At risk (high value) 21.4%, Lost / hibernating 13.3%." style="display: block; margin: auto;" />

The vignette gives the full readings for each segment.

## Example 2: the standard segments

The classic ten segments are defined on the three separate score boxes,
and `rfm_segment()` applies them in order with the first match winning.
The ten rules overlap in 58 of the 125 R x F x M score cells, so list
order matters: “Potential Loyalist” covers many high-frequency,
high-monetary customers because it is listed second with a wide box (R
3–5, F 3–5, M 2–5). Ten cells match no rule at all; customers there
become `Others` (none in this data). Each bound below is inclusive on
both ends.

``` r
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
#> # A tibble: 995 × 12
#>   customer_id    segment         rfm_score transaction_count recency_days amount
#>   <chr>          <chr>               <dbl>             <int>        <dbl>  <int>
#> 1 Abbey O'Reilly Potential Loya…       343                 6          205    472
#> 2 Add Senger     New Customers         412                 3          140    340
#> 3 Aden Lesch     Loyal Customers       323                 4          194    405
#> 4 Aden Murphy    Potential Loya…       544                 7           98    596
#> 5 Admiral Senger Potential Loya…       433                 5          132    448
#> # ℹ 990 more rows
#> # ℹ 6 more variables: recency_score <int>, frequency_score <int>,
#> #   monetary_score <int>, first_name <chr>, last_name <chr>, email <chr>
```

## Plotting Engines

`rfm` supports the following plotting engines:

- [ggplot2](https://ggplot2.tidyverse.org)
- [plotly](https://plotly.com/r/)
- [gganimate](https://gganimate.com)

## Shiny App

`rfm` includes a shiny app for interactive RFM analysis. In the latest
release, we have added project management features to allow users to
save/clone their projects.

## Resources

- [Package website](https://rfm.rsquaredacademy.com)
- [Reference
  documentation](https://rfm.rsquaredacademy.com/reference/index.html)
- [Vignette](https://rfm.rsquaredacademy.com/articles/rfm-introduction.html)

## Getting Help

If you encounter a bug, please file a minimal reproducible example using
[reprex](https://reprex.tidyverse.org/index.html) on github. For
questions and clarifications, please ask on Stack Overflow.

<div data-rsa-signup="" data-site="rfm.rsquaredacademy.com"
data-privacy-url="https://www.rsquaredacademy.com/privacy-policy.html">

</div>

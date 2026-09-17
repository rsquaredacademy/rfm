# Segmentation

Create segments based on recency, frequency and monetary scores.

## Usage

``` r
rfm_segment(
  data,
  segment_names = NULL,
  recency_lower = NULL,
  recency_upper = NULL,
  frequency_lower = NULL,
  frequency_upper = NULL,
  monetary_lower = NULL,
  monetary_upper = NULL
)
```

## Arguments

- data:

  An object of class `rfm_table`.

- segment_names:

  Names of the segments.

- recency_lower:

  Lower boundary for recency score.

- recency_upper:

  Upper boundary for recency score.

- frequency_lower:

  Lower boundary for frequency score.

- frequency_upper:

  Upper boundary for frequency score.

- monetary_lower:

  Lower boundary for monetary score.

- monetary_upper:

  Upper boundary for monetary score.

## Examples

``` r
# analysis date
analysis_date <- as.Date('2006-12-31')

# generate rfm score
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

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
#>    customer_id    segment        rfm_score transaction_count recency_days amount
#>    <chr>          <chr>              <dbl>             <int>        <dbl>  <int>
#>  1 Abbey O'Reilly Potential Loy…       343                 6          205    472
#>  2 Add Senger     New Customers        412                 3          140    340
#>  3 Aden Lesch     Loyal Custome…       323                 4          194    405
#>  4 Aden Murphy    Potential Loy…       544                 7           98    596
#>  5 Admiral Senger Potential Loy…       433                 5          132    448
#>  6 Agness O'Keefe Champions            555                 9           90    843
#>  7 Aileen Barton  Champions            555                 9           84    763
#>  8 Ailene Hermann Potential Loy…       355                 8          281    699
#>  9 Aiyanna Bruen  About To Sleep       321                 4          246    157
#> 10 Akeelah Walsh  Potential Loy…       445                 7          160    779
#> # ℹ 985 more rows
#> # ℹ 6 more variables: recency_score <int>, frequency_score <int>,
#> #   monetary_score <int>, first_name <chr>, last_name <chr>, email <chr>
```

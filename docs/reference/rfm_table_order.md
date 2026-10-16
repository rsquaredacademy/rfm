# RFM table (transaction data)

Recency, frequency, monetary and RFM score.

## Usage

``` r
rfm_table_order(
  data = NULL,
  customer_id = NULL,
  order_date = NULL,
  revenue = NULL,
  analysis_date = NULL,
  recency_bins = 5,
  frequency_bins = 5,
  monetary_bins = 5,
  ...
)
```

## Arguments

- data:

  A `data.frame` or `tibble`.

- customer_id:

  Unique id of the customer.

- order_date:

  Date of the transaction.

- revenue:

  Revenue from the customer.

- analysis_date:

  Date of analysis.

- recency_bins:

  Number of bins for recency or custom threshold.

- frequency_bins:

  Number of bins for frequency or custom threshold.

- monetary_bins:

  Number of bins for monetary or custom threshold.

- ...:

  Other arguments.

## Value

`rfm_table_order` returns a list with the following:

- rfm:

  RFM table.

- analysis_date:

  Date of analysis.

- frequency_bins:

  Number of bins used for frequency score.

- recency_bins:

  Number of bins used for recency score.

- monetary_bins:

  Number of bins used for monetary score.

- threshold:

  thresholds used for generating RFM scores.

## Examples

``` r
analysis_date <- as.Date("2006-12-31")
rfm_table_order(
  rfm_data_orders, customer_id, order_date, revenue,
  analysis_date
)
#> # A tibble: 995 × 11
#>    customer_id    recency_days transaction_count amount recency_score
#>    <chr>                 <dbl>             <int>  <int>         <int>
#>  1 Abbey O'Reilly          205                 6    472             3
#>  2 Add Senger              140                 3    340             4
#>  3 Aden Lesch              194                 4    405             3
#>  4 Aden Murphy              98                 7    596             5
#>  5 Admiral Senger          132                 5    448             4
#>  6 Agness O'Keefe           90                 9    843             5
#>  7 Aileen Barton            84                 9    763             5
#>  8 Ailene Hermann          281                 8    699             3
#>  9 Aiyanna Bruen           246                 4    157             3
#> 10 Akeelah Walsh           160                 7    779             4
#> # ℹ 985 more rows
#> # ℹ 6 more variables: frequency_score <int>, monetary_score <int>,
#> #   rfm_score <dbl>, first_name <chr>, last_name <chr>, email <chr>

# access rfm table
result <- rfm_table_order(
  rfm_data_orders, customer_id, order_date,
  revenue, analysis_date
)
result$rfm
#> # A tibble: 995 × 11
#>    customer_id    recency_days transaction_count amount recency_score
#>    <chr>                 <dbl>             <int>  <int>         <int>
#>  1 Abbey O'Reilly          205                 6    472             3
#>  2 Add Senger              140                 3    340             4
#>  3 Aden Lesch              194                 4    405             3
#>  4 Aden Murphy              98                 7    596             5
#>  5 Admiral Senger          132                 5    448             4
#>  6 Agness O'Keefe           90                 9    843             5
#>  7 Aileen Barton            84                 9    763             5
#>  8 Ailene Hermann          281                 8    699             3
#>  9 Aiyanna Bruen           246                 4    157             3
#> 10 Akeelah Walsh           160                 7    779             4
#> # ℹ 985 more rows
#> # ℹ 6 more variables: frequency_score <int>, monetary_score <int>,
#> #   rfm_score <dbl>, first_name <chr>, last_name <chr>, email <chr>

# using custom threshold
rfm_table_order(rfm_data_orders, customer_id, order_date, revenue,
  analysis_date,
  recency_bins = c(115, 181, 297, 482), frequency_bins = c(4, 5, 6, 8),
  monetary_bins = c(256, 382, 506, 666)
)
#> # A tibble: 995 × 11
#>    customer_id    recency_days transaction_count amount recency_score
#>    <chr>                 <dbl>             <int>  <int>         <int>
#>  1 Abbey O'Reilly          205                 6    472             3
#>  2 Add Senger              140                 3    340             4
#>  3 Aden Lesch              194                 4    405             3
#>  4 Aden Murphy              98                 7    596             5
#>  5 Admiral Senger          132                 5    448             4
#>  6 Agness O'Keefe           90                 9    843             5
#>  7 Aileen Barton            84                 9    763             5
#>  8 Ailene Hermann          281                 8    699             3
#>  9 Aiyanna Bruen           246                 4    157             3
#> 10 Akeelah Walsh           160                 7    779             4
#> # ℹ 985 more rows
#> # ℹ 6 more variables: frequency_score <int>, monetary_score <int>,
#> #   rfm_score <dbl>, first_name <chr>, last_name <chr>, email <chr>
```

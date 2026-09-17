# Heatmap data

Data for generating heatmap.

## Usage

``` r
rfm_heatmap_data(rfm_table)
```

## Arguments

- rfm_table:

  An object of class `rfm_table`.

## Examples

``` r
# using transaction data
analysis_date <- as.Date('2006-12-31')
rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

# heat map data
rfm_heatmap_data(rfm_order)
#> # A tibble: 25 × 3
#> # Groups:   frequency_score [5]
#>    frequency_score recency_score monetary
#>              <int>         <int>    <dbl>
#>  1               1             1     208.
#>  2               1             2     247.
#>  3               1             3     246.
#>  4               1             4     213.
#>  5               1             5     262.
#>  6               2             1     380.
#>  7               2             2     408.
#>  8               2             3     355.
#>  9               2             4     375.
#> 10               2             5     370.
#> # ℹ 15 more rows

# using customer data
analysis_date <- as.Date('2007-01-01')
rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
number_of_orders, recency_days, revenue, analysis_date)

# heat map data
rfm_heatmap_data(rfm_customer)
#> # A tibble: 25 × 3
#> # Groups:   frequency_score [5]
#>    frequency_score recency_score monetary
#>              <int>         <int>    <dbl>
#>  1               1             1     537.
#>  2               1             2     571.
#>  3               1             3     580.
#>  4               1             4     584.
#>  5               1             5     593.
#>  6               2             1     812.
#>  7               2             2     814.
#>  8               2             3     811.
#>  9               2             4     822.
#> 10               2             5     813.
#> # ℹ 15 more rows
```

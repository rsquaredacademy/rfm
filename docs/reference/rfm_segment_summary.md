# Segment summary

An overview of customer segments.

## Usage

``` r
rfm_segment_summary(segments)
```

## Arguments

- segments:

  Output from `rfm_segment`.

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

# segment summary
rfm_segment_summary(segments)
#> # A tibble: 10 × 5
#>    segment            customers orders revenue   aov
#>    <chr>                  <int>  <int>   <int> <dbl>
#>  1 About To Sleep           102    283   23449  82.9
#>  2 At Risk                   28    216   22227 103. 
#>  3 Can't Lose Them           47    274   32446 118. 
#>  4 Champions                 35    316   31646 100. 
#>  5 Lost                     148    393   35324  89.9
#>  6 Loyal Customers          170    799   76562  95.8
#>  7 Need Attention            10     57    4562  80.0
#>  8 New Customers            104    329   28837  87.6
#>  9 Potential Loyalist       342   2211  204856  92.6
#> 10 Promising                  9     28    4249 152. 
```

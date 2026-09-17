# RFM report

Generates a segmentation analysis report.

## Usage

``` r
rfm_create_report(
  rfm_table,
  segments,
  interactive = FALSE,
  title = NULL,
  author = NULL,
  folder_name = NULL,
  file_name = NULL
)
```

## Arguments

- rfm_table:

  An object of class `rfm_table`.

- segments:

  Output from `rfm_segment`.

- interactive:

  If `TRUE`, uses `plotly` as the visualization engine. If `FALSE`, uses
  `ggplot2`.

- title:

  Title of the report.

- author:

  Author of the report.

- folder_name:

  The output directory for the report.

- file_name:

  The name of the report file.

## Examples

``` r
if (FALSE) { # \dontrun{
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

rfm_create_report(rfm_result, segments, FALSE,
"Customer Segmentation Report")
} # }
```

# RFM histograms

Histograms of recency, frequency and monetary value.

## Usage

``` r
rfm_plot_histogram(
  rfm_table,
  metric = "recency",
  hist_bins = 9,
  hist_color = NULL,
  plot_title = NULL,
  xaxis_label = NULL,
  yaxis_label = NULL,
  interactive = FALSE,
  print_plot = TRUE
)
```

## Arguments

- rfm_table:

  An object of class `rfm_table`.

- metric:

  Metric to be visualized. Defaults to `"recency"`. Valid values are:

  - `"recency"`

  - `"frequency"`

  - `"monetary"`

- hist_bins:

  Number of bins of the histograms.

- hist_color:

  Color of the histogram.

- plot_title:

  Title of the plot.

- xaxis_label:

  X axis label.

- yaxis_label:

  Y axis label.

- interactive:

  If `TRUE`, uses `plotly` as the visualization engine. If `FALSE`, uses
  `ggplot2`.

- print_plot:

  logical; if `TRUE`, prints the plot else returns a plot object.

## Value

Histograms

## Deprecated Functions

`rfm_histograms()` has been deprecated and will be made defunct. It has
been provided for compatibility with older versions only, and will be
made defunct at the next release.

Instead use the replacement function `rfm_plot_histogram()`.

## Examples

``` r
# using transaction data
analysis_date <- as.Date('2006-12-31')
rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

# histogram
# ggplot2
rfm_plot_histogram(rfm_order, metric = "frequency")


# plotly
rfm_plot_histogram(rfm_order, metric = "frequency", interactive = TRUE)

# using customer data
analysis_date <- as.Date('2007-01-01')
rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
number_of_orders, recency_days, revenue, analysis_date)

# histogram
rfm_plot_histogram(rfm_customer)

```

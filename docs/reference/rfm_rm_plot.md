# RFM Scatter plot

Examine the relationship between recency, frequency and monetary values.

## Usage

``` r
rfm_rm_plot(
  segments,
  xaxis_label = NULL,
  yaxis_label = NULL,
  plot_title = NULL,
  print_plot = TRUE
)

rfm_fm_plot(
  segments,
  xaxis_label = NULL,
  yaxis_label = NULL,
  plot_title = NULL,
  print_plot = TRUE
)

rfm_rf_plot(
  segments,
  xaxis_label = NULL,
  yaxis_label = NULL,
  plot_title = NULL,
  print_plot = TRUE
)
```

## Arguments

- segments:

  Output from `rfm_segment`.

- xaxis_label:

  X axis label.

- yaxis_label:

  Y axis label.

- plot_title:

  Title of the plot.

- print_plot:

  logical; if `TRUE`, prints the plot else returns a plot object.

## Value

Scatter plot.

## Deprecated Functions

`rfm_rm_plot()`, `rfm_fm_plot()` and `rfm_rf_plot()` have been
deprecated and will be made defunct. These functions have been provided
for compatibility with older versions only, and will be made defunct at
the next release. Instead use the replacement function
[`rfm_plot_segment_scatter()`](https://rfm.rsquaredacademy.com/reference/rfm_plot_segment_scatter.md).

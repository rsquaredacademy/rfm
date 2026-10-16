# Median plots

Segment wise median recency, frequency & monetary value plot.

## Usage

``` r
rfm_plot_median_recency(
  rfm_segment_table,
  sort = FALSE,
  ascending = FALSE,
  flip = FALSE,
  bar_color = NULL,
  plot_title = NULL,
  xaxis_label = NULL,
  yaxis_label = NULL,
  axis_label_size = 8,
  axis_label_angle = 315,
  bar_labels = TRUE,
  interactive = FALSE,
  animate = FALSE,
  print_plot = TRUE
)

rfm_plot_median_frequency(
  rfm_segment_table,
  sort = FALSE,
  ascending = FALSE,
  flip = FALSE,
  bar_color = NULL,
  plot_title = NULL,
  xaxis_label = NULL,
  yaxis_label = NULL,
  axis_label_size = 8,
  axis_label_angle = 315,
  bar_labels = TRUE,
  interactive = FALSE,
  animate = FALSE,
  print_plot = TRUE
)

rfm_plot_median_monetary(
  rfm_segment_table,
  sort = FALSE,
  ascending = FALSE,
  flip = FALSE,
  bar_color = NULL,
  plot_title = NULL,
  xaxis_label = NULL,
  yaxis_label = NULL,
  axis_label_size = 8,
  axis_label_angle = 315,
  bar_labels = TRUE,
  interactive = FALSE,
  animate = FALSE,
  print_plot = TRUE
)
```

## Arguments

- rfm_segment_table:

  Output from `rfm_segment`.

- sort:

  logical; if `TRUE`, sort metrics.

- ascending:

  logical; if `TRUE`, sort metrics in ascending order.

- flip:

  logical; if `TRUE`, creates horizontal bar plot.

- bar_color:

  Color of the bars.

- plot_title:

  Title of the plot.

- xaxis_label:

  X axis label.

- yaxis_label:

  Y axis label.

- axis_label_size:

  Font size of X axis tick labels.

- axis_label_angle:

  Angle of X axis tick labels.

- bar_labels:

  If `TRUE`, add labels to the bars. Defaults to `TRUE`.

- interactive:

  If `TRUE`, uses `plotly` as the visualization engine. If `FALSE`, uses
  `ggplot2`.

- animate:

  If `TRUE`, animates the bars. Defaults to `FALSE`.

- print_plot:

  logical; if `TRUE`, prints the plot else returns a plot object.

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

# plots
# visualize median recency
rfm_plot_median_recency(segments)


# plotly
rfm_plot_median_recency(segments, interactive = TRUE)

{"x":{"visdat":{"4d82508105e":["function () ","plotlyVisDat"]},"cur_data":"4d82508105e","attrs":{"4d82508105e":{"x":{},"y":{},"hoverinfo":"text","hovertext":["Segment: Champions <br />Median Recency: 53","Segment: New Customers <br />Median Recency: 101.5","Segment: Potential Loyalist <br />Median Recency: 151.5","Segment: Promising <br />Median Recency: 231","Segment: About To Sleep <br />Median Recency: 331","Segment: Loyal Customers <br />Median Recency: 356.5","Segment: At Risk <br />Median Recency: 453.5","Segment: Can't Lose Them <br />Median Recency: 494","Segment: Need Attention <br />Median Recency: 508.5","Segment: Lost <br />Median Recency: 576"],"marker":{"color":"#0f1a34"},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"<b>Median Recency  by Segment<\/b>","xaxis":{"domain":[0,1],"automargin":true,"title":"<b>Segment<\/b>","type":"category","categoryorder":"array","categoryarray":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"<b>Median Recency<\/b>"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"displayModeBar":false},"data":[{"x":["Champions","New Customers","Potential Loyalist","Promising","About To Sleep","Loyal Customers","At Risk","Can't Lose Them","Need Attention","Lost"],"y":[53,101.5,151.5,231,331,356.5,453.5,494,508.5,576],"hoverinfo":["text","text","text","text","text","text","text","text","text","text"],"hovertext":["Segment: Champions <br />Median Recency: 53","Segment: New Customers <br />Median Recency: 101.5","Segment: Potential Loyalist <br />Median Recency: 151.5","Segment: Promising <br />Median Recency: 231","Segment: About To Sleep <br />Median Recency: 331","Segment: Loyal Customers <br />Median Recency: 356.5","Segment: At Risk <br />Median Recency: 453.5","Segment: Can't Lose Them <br />Median Recency: 494","Segment: Need Attention <br />Median Recency: 508.5","Segment: Lost <br />Median Recency: 576"],"marker":{"color":"#0f1a34","line":{"color":"rgba(31,119,180,1)"}},"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
# sort in ascending order
rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE)


# default sorting is in descending order
rfm_plot_median_recency(segments, sort = TRUE)


# horizontal bars
rfm_plot_median_recency(segments, flip = TRUE)


# median frequency
rfm_plot_median_frequency(segments)


# median monetary value
rfm_plot_median_monetary(segments)

```

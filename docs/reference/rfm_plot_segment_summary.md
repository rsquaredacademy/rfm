# Visulaize segment summary

Generates plots for customers, orders, revenue and average order value
for each segment.

## Usage

``` r
rfm_plot_segment_summary(
  x,
  metric = NULL,
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

- x:

  An object of class `rfm_segment_summary`.

- metric:

  Metric to be visualized. Defaults to `"customers"`. Valid values are:

  - `"customers"`

  - `"orders"`

  - `"revenue"`

  - `"aov"`

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

# segment summary
segment_overview <- rfm_segment_summary(segments)

# plot segment summary
# summarize metric for all segments
# ggplot2
rfm_plot_segment_summary(segment_overview)


# plotly
rfm_plot_segment_summary(segment_overview, interactive = TRUE)

{"x":{"visdat":{"2810610b555a":["function () ","plotlyVisDat"]},"cur_data":"2810610b555a","attrs":{"2810610b555a":{"x":{},"y":{},"hoverinfo":"text","hovertext":["Segment: About To Sleep<br />Customers: 102","Segment: At Risk<br />Customers: 28","Segment: Can't Lose Them<br />Customers: 47","Segment: Champions<br />Customers: 35","Segment: Lost<br />Customers: 148","Segment: Loyal Customers<br />Customers: 170","Segment: Need Attention<br />Customers: 10","Segment: New Customers<br />Customers: 104","Segment: Potential Loyalist<br />Customers: 342","Segment: Promising<br />Customers: 9"],"marker":{"color":"#0f1a34"},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"<b>Customers  Distribution by Segment<\/b>","xaxis":{"domain":[0,1],"automargin":true,"title":"<b>Segment<\/b>","type":"category","categoryorder":"array","categoryarray":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"<b>Customers<\/b>"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"displayModeBar":false},"data":[{"x":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"],"y":[102,28,47,35,148,170,10,104,342,9],"hoverinfo":["text","text","text","text","text","text","text","text","text","text"],"hovertext":["Segment: About To Sleep<br />Customers: 102","Segment: At Risk<br />Customers: 28","Segment: Can't Lose Them<br />Customers: 47","Segment: Champions<br />Customers: 35","Segment: Lost<br />Customers: 148","Segment: Loyal Customers<br />Customers: 170","Segment: Need Attention<br />Customers: 10","Segment: New Customers<br />Customers: 104","Segment: Potential Loyalist<br />Customers: 342","Segment: Promising<br />Customers: 9"],"marker":{"color":"#0f1a34","line":{"color":"rgba(31,119,180,1)"}},"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
# select metric to be visualized
rfm_plot_segment_summary(segment_overview, metric = "orders")


# sort the metric in ascending order
rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE,
  ascending = TRUE)


# default sorting is in descending order
rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE)


# horizontal bars
rfm_plot_segment_summary(segment_overview, metric = "orders", flip = TRUE)

```

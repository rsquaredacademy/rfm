# Revenue distribution

Customer and revenue distribution by segments.

## Usage

``` r
rfm_plot_revenue_dist(
  x,
  flip = FALSE,
  colors = c("#3b5bdb", "#91a7ff"),
  legend_labels = c("Revenue", "Customers"),
  plot_title = "Revenue & Customer Distribution",
  xaxis_label = NULL,
  yaxis_label = NULL,
  axis_label_size = 8,
  axis_label_angle = 315,
  bar_labels = FALSE,
  bar_label_size = 2,
  interactive = FALSE,
  animate = FALSE,
  print_plot = TRUE
)
```

## Arguments

- x:

  An object of class `rfm_segment_summary`.

- flip:

  logical; if `TRUE`, creates horizontal bar plot.

- colors:

  Bar colors.

- legend_labels:

  Legend labels.

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

  If `TRUE`, add labels to the bars. Defaults to `FALSE`.

- bar_label_size:

  Size of bar labels.

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

# revenue distribution
# ggplot2
rfm_plot_revenue_dist(segment_overview)


# flip
rfm_plot_revenue_dist(segment_overview, flip = TRUE)


# plotly
rfm_plot_revenue_dist(segment_overview, interactive = TRUE)

{"x":{"visdat":{"7b7850cd5121":["function () ","plotlyVisDat"]},"cur_data":"7b7850cd5121","attrs":{"7b7850cd5121":{"x":{},"y":{},"hoverinfo":"text","hovertext":["Segment: About To Sleep<br />Revenue Share: 5%","Segment: At Risk<br />Revenue Share: 4.79%","Segment: Can't Lose Them<br />Revenue Share: 7.14%","Segment: Champions<br />Revenue Share: 6.82%","Segment: Lost<br />Revenue Share: 7.61%","Segment: Loyal Customers<br />Revenue Share: 16.55%","Segment: Need Attention<br />Revenue Share: 0.98%","Segment: New Customers<br />Revenue Share: 6.21%","Segment: Potential Loyalist<br />Revenue Share: 43.98%","Segment: Promising<br />Revenue Share: 0.92%"],"marker":{"color":"#3b5bdb"},"name":"Revenue","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"},"7b7850cd5121.1":{"x":{},"y":{},"hoverinfo":"text","hovertext":["Segment: About To Sleep<br />Customer Share: 10.15%","Segment: At Risk<br />Customer Share: 2.81%","Segment: Can't Lose Them<br />Customer Share: 4.82%","Segment: Champions<br />Customer Share: 3.52%","Segment: Lost<br />Customer Share: 14.87%","Segment: Loyal Customers<br />Customer Share: 17.19%","Segment: Need Attention<br />Customer Share: 1.01%","Segment: New Customers<br />Customer Share: 10.45%","Segment: Potential Loyalist<br />Customer Share: 34.27%","Segment: Promising<br />Customer Share: 0.9%"],"marker":{"color":"#91a7ff"},"name":"Customers","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar","inherit":true}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"<b>Revenue & Customer Distribution<\/b>","xaxis":{"domain":[0,1],"automargin":true,"title":"<b><\/b>","type":"category","categoryorder":"array","categoryarray":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"<b><\/b>","ticksuffix":"%"},"legend":{"x":100,"y":0.5},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"displayModeBar":false},"data":[{"x":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"],"y":[5,4.79,7.1399999999999997,6.8200000000000003,7.6100000000000003,16.550000000000001,0.97999999999999998,6.21,43.979999999999997,0.92000000000000004],"hoverinfo":["text","text","text","text","text","text","text","text","text","text"],"hovertext":["Segment: About To Sleep<br />Revenue Share: 5%","Segment: At Risk<br />Revenue Share: 4.79%","Segment: Can't Lose Them<br />Revenue Share: 7.14%","Segment: Champions<br />Revenue Share: 6.82%","Segment: Lost<br />Revenue Share: 7.61%","Segment: Loyal Customers<br />Revenue Share: 16.55%","Segment: Need Attention<br />Revenue Share: 0.98%","Segment: New Customers<br />Revenue Share: 6.21%","Segment: Potential Loyalist<br />Revenue Share: 43.98%","Segment: Promising<br />Revenue Share: 0.92%"],"marker":{"color":"#3b5bdb","line":{"color":"rgba(31,119,180,1)"}},"name":"Revenue","type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":["About To Sleep","At Risk","Can't Lose Them","Champions","Lost","Loyal Customers","Need Attention","New Customers","Potential Loyalist","Promising"],"y":[10.15,2.8100000000000001,4.8200000000000003,3.52,14.869999999999999,17.190000000000001,1.01,10.449999999999999,34.270000000000003,0.90000000000000002],"hoverinfo":["text","text","text","text","text","text","text","text","text","text"],"hovertext":["Segment: About To Sleep<br />Customer Share: 10.15%","Segment: At Risk<br />Customer Share: 2.81%","Segment: Can't Lose Them<br />Customer Share: 4.82%","Segment: Champions<br />Customer Share: 3.52%","Segment: Lost<br />Customer Share: 14.87%","Segment: Loyal Customers<br />Customer Share: 17.19%","Segment: Need Attention<br />Customer Share: 1.01%","Segment: New Customers<br />Customer Share: 10.45%","Segment: Potential Loyalist<br />Customer Share: 34.27%","Segment: Promising<br />Customer Share: 0.9%"],"marker":{"color":"#91a7ff","line":{"color":"rgba(255,127,14,1)"}},"name":"Customers","type":"bar","error_y":{"color":"rgba(255,127,14,1)"},"error_x":{"color":"rgba(255,127,14,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```

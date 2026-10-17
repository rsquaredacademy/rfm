# Customers by orders

Visualize the distribution of customers across orders.

## Usage

``` r
rfm_plot_order_dist(
  rfm_table,
  flip = FALSE,
  bar_color = NULL,
  plot_title = NULL,
  xaxis_label = NULL,
  yaxis_label = NULL,
  bar_label_size = 3,
  bar_labels = TRUE,
  interactive = FALSE,
  animate = FALSE,
  print_plot = TRUE
)
```

## Arguments

- rfm_table:

  An object of class `rfm_table`.

- flip:

  logical; if `TRUE`, creates horizontal bar plot.

- bar_color:

  Color of the bars.

- plot_title:

  Title of the plot.

- xaxis_label:

  X axis title.

- yaxis_label:

  Y axis title.

- bar_label_size:

  Size of bar labels.

- bar_labels:

  If `TRUE`, add labels to the bars. Defaults to `TRUE`.

- interactive:

  If `TRUE`, uses `plotly` as the visualization engine. If `FALSE`, uses
  `ggplot2`.

- animate:

  If `TRUE`, animates the bars. Defaults to `FALSE`.

- print_plot:

  logical; if `TRUE`, prints the plot else returns a plot object.

## Value

Bar chart.

## Deprecated Functions

`rfm_order_dist()` has been deprecated and will be made defunct. It has
been provided for compatibility with older versions only, and will be
made defunct at the next release.

Instead use the replacement function `rfm_plot_order_dist()`.

## Examples

``` r
# using transaction data
analysis_date <- as.Date('2006-12-31')
rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

# order distribution
rfm_plot_order_dist(rfm_order)


# horizontal bars
rfm_plot_order_dist(rfm_order, flip = TRUE)


# plotly
rfm_plot_order_dist(rfm_order, interactive = TRUE)

{"x":{"visdat":{"28101724904":["function () ","plotlyVisDat"]},"cur_data":"28101724904","attrs":{"28101724904":{"x":{},"y":{},"hoverinfo":"text","hovertext":["Orders: 1 <br />Customers: 42","Orders: 2 <br />Customers: 83","Orders: 3 <br />Customers: 143","Orders: 4 <br />Customers: 187","Orders: 5 <br />Customers: 176","Orders: 6 <br />Customers: 150","Orders: 7 <br />Customers: 94","Orders: 8 <br />Customers: 51","Orders: 9 <br />Customers: 38","Orders: 10 <br />Customers: 20","Orders: 11 <br />Customers: 3","Orders: 12 <br />Customers: 5","Orders: 13 <br />Customers: 2","Orders: 14 <br />Customers: 1"],"marker":{"color":"#0f1a34"},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"<b>Customer Distribution by Orders<\/b>","xaxis":{"domain":[0,1],"automargin":true,"title":"<b>Orders<\/b>"},"yaxis":{"domain":[0,1],"automargin":true,"title":"<b>Customers<\/b>"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"displayModeBar":false},"data":[{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14],"y":[42,83,143,187,176,150,94,51,38,20,3,5,2,1],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"hovertext":["Orders: 1 <br />Customers: 42","Orders: 2 <br />Customers: 83","Orders: 3 <br />Customers: 143","Orders: 4 <br />Customers: 187","Orders: 5 <br />Customers: 176","Orders: 6 <br />Customers: 150","Orders: 7 <br />Customers: 94","Orders: 8 <br />Customers: 51","Orders: 9 <br />Customers: 38","Orders: 10 <br />Customers: 20","Orders: 11 <br />Customers: 3","Orders: 12 <br />Customers: 5","Orders: 13 <br />Customers: 2","Orders: 14 <br />Customers: 1"],"marker":{"color":"#0f1a34","line":{"color":"rgba(31,119,180,1)"}},"type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
# using customer data
analysis_date <- as.Date('2007-01-01')
rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
number_of_orders, recency_days, revenue, analysis_date)

# order distribution
rfm_plot_order_dist(rfm_customer)

```

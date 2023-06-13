#' @importFrom plotly plot_ly layout config
rfm_plotly_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n, brewer_name, legend_title) {

  text <- paste0("Frequency Score: ", mapdata$frequency_score,
                 "\nRecency Score: ", mapdata$recency_score,
                 "\nMean Monetary Value: ", round(mapdata$monetary, 2))

  fig <-
    plot_ly(
      data = mapdata,
      x = ~frequency_score,
      y = ~recency_score,
      z = ~monetary,
      colors = RColorBrewer::brewer.pal(n = brewer_n, name = brewer_name),
      type = "heatmap",
      colorbar = list(title = legend_title),
      hoverinfo = "text",
      hovertext = text
    )

  fig <-
    fig %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label))

  fig %>%
    config(displayModeBar = FALSE)
}

rfm_plotly_order_dist <- function(data, flip = FALSE, bar_color = NULL,
                                  plot_title = NULL,
                                  xaxis_label = NULL,
                                  yaxis_label = NULL) {

  text <- paste0("Orders: ", data$transaction_count, " \nCustomers: ", data$n)

  if (flip) {
    fig <- plot_ly(data,
                   x = ~n,
                   y = ~transaction_count,
                   type = "bar",
                   hoverinfo = "text",
                   hovertext = text,
                   orientation = 'h',
                   marker = list(
                     color = bar_color
                   ))
  } else {
    fig <- plot_ly(data,
                   x = ~transaction_count,
                   y = ~n,
                   type = "bar",
                   hoverinfo = "text",
                   hovertext = text,
                   marker = list(
                     color = bar_color
                   ))
  }

  fig <-
    fig %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label))

  fig %>%
    config(displayModeBar = FALSE)

}

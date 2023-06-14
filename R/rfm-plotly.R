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

rfm_plotly_hist <- function(data, hist_color = NULL, plot_title = NULL,
                            xaxis_label = NULL, yaxis_label = NULL) {

  fig <- plot_ly(data,
                 x = ~score,
                 type = "histogram",
                 histnorm = "count",
                 autobinx = TRUE,
                 marker = list(
                   color = hist_color,
                   line = list(
                     color = "white",
                     width = 1.5
                   )
                 ))


  fig <-
    fig %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label))

  fig %>%
    config(displayModeBar = FALSE)

}

rfm_plotly_segment_summary <- function(data, metric, flip, sort, ascending, bar_color, plot_title, xaxis_label, yaxis_label) {

  text <- paste0("Segment: ", data[["segment"]],
                 "\n", to_title_case(metric), ": ", data[[metric]])

  if (flip) {
    fig <- plot_ly(data,
                   y = ~segment,
                   x = ~get(metric),
                   type = "bar",
                   hoverinfo = "text",
                   hovertext = text,
                   orientation = 'h',
                   marker = list(
                     color = bar_color
                   ))

    if (sort) {
      if (ascending) {
        fig <- fig %>%
          layout(title = plot_title,
                 xaxis = list(title = yaxis_label),
                 yaxis = list(title = xaxis_label,
                              categoryorder = "total descending"))
      } else {
        fig <- fig %>%
          layout(title = plot_title,
                 xaxis = list(title = yaxis_label),
                 yaxis = list(title = xaxis_label,
                              categoryorder = "total ascending"))
      }
    } else {
      fig <- fig %>%
        layout(title = plot_title,
               xaxis = list(title = yaxis_label),
               yaxis = list(title = xaxis_label))
    }

  } else {
    fig <- plot_ly(data,
                   x = ~segment,
                   y = ~get(metric),
                   type = "bar",
                   hoverinfo = "text",
                   hovertext = text,
                   marker = list(
                     color = bar_color
                   ))
    if (sort) {
      if (ascending) {
        fig <- fig %>%
          layout(title = plot_title,
                 xaxis = list(title = xaxis_label,
                              categoryorder = "total ascending"),
                 yaxis = list(title = yaxis_label))
      } else {
        fig <- fig %>%
          layout(title = plot_title,
                 xaxis = list(title = xaxis_label,
                              categoryorder = "total descending"),
                 yaxis = list(title = yaxis_label))
      }
    } else {
      fig <- fig %>%
        layout(title = plot_title,
               xaxis = list(title = xaxis_label),
               yaxis = list(title = yaxis_label))
    }
  }

  fig %>%
    config(displayModeBar = FALSE)

}

#' @importFrom plotly plot_ly layout config add_trace
rfm_plotly_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label,
                               brewer_n, brewer_name, legend_title) {

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

rfm_plotly_segment_summary <- function(data, metric, flip, sort, ascending,
                                       bar_color, plot_title, xaxis_label,
                                       yaxis_label) {

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


rfm_plotly_revenue_dist <- function(x, flip = FALSE,
                                    colors = c("#3b5bdb", "#91a7ff"),
                                    labels = c("Revenue", "Customers"),
                                    plot_title = "Revenue & Customer Distribution",
                                    xaxis_label = NULL, yaxis_label = NULL) {

  x$customer_share <- round((x$customers / sum(x$customers)) * 100, 2)
  x$revenue_share <- round((x$revenue / sum(x$revenue)) * 100, 2)
  data <- x[c("segment", "customer_share", "revenue_share")]

  customer_text <- paste0("Segment: ", data$segment,
                          "\nCustomer Share: ", data$customer_share, "%")

  revenue_text <- paste0("Segment: ", data$segment,
                         "\nRevenue Share: ", data$revenue_share, "%")

  if (is.null(xaxis_label)) {
    xaxis_label <- ""
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- ""
  }

  if (flip) {
    fig <-
    plot_ly(data,
            x = ~revenue_share,
            y = ~segment,
            type = 'bar',
            orientation = "h",
            name = labels[1],
            hoverinfo = "text",
            hovertext = revenue_text,
            marker = list(color = colors[1])) %>%
    add_trace(x = ~customer_share,
              name = labels[2],
              hoverinfo = "text",
              hovertext = customer_text,
              marker = list(color = colors[2])) %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label, ticksuffix = "%"),
           yaxis = list(title = yaxis_label),
           legend = list(x = 100, y = 0.5))
  } else {
    fig <-
    plot_ly(data,
            x = ~segment,
            y = ~revenue_share,
            type = 'bar',
            name = labels[1],
            hoverinfo = "text",
            hovertext = revenue_text,
            marker = list(color = colors[1])) %>%
    add_trace(y = ~customer_share,
              name = labels[2],
              hoverinfo = "text",
              hovertext = customer_text,
              marker = list(color = colors[2])) %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label, ticksuffix = "%"),
           legend = list(x = 100, y = 0.5))
  }

  fig <-
    fig %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label, ticksuffix = "%"),
           legend = list(x = 100, y = 0.5))

  fig %>%
    config(displayModeBar = FALSE)

}


rfm_plotly_segment <- function(table, metric = "customers") {

  text <- paste0("Segment:", toupper(table$segment), "\n",
                 rfm:::to_title_case(metric), ": ", table[[metric]],
                 " (", table$prop, "%)")

  fig <- plot_ly(
    type = "treemap",
    labels = table$segment,
    parents = rep("", nrow(table)),
    values = table[[metric]],
    hoverinfo = "text",
    hovertext = text
  )

  fig %>%
    config(displayModeBar = FALSE)
}

rfm_plotly_segment_scatter <- function(segments, x_data = NULL, y_data = NULL,
                                       plot_title = NULL, legend_title = NULL,
                                       xaxis_label = NULL, yaxis_label = NULL) {

  if (is.null(legend_title)) {
    legend_title <- paste0('<b> ', legend_title , ' </b>')
  } else {
    legend_title <- legend_title
  }

  text <- paste0("Amount: ", segments[[x_data]], "\nRecency: ",
                 segments[[y_data]], "\nSegment: ", segments$segment)



  fig <- plot_ly(segments,
                 x = ~get(x_data),
                 y = ~get(y_data),
                 type = "scatter",
                 mode = "markers",
                 color = ~factor(segment),
                 colors = "Paired",
                 hoverinfo = "text",
                 hovertext = text)


  fig <-
    fig %>%
    layout(title = plot_title,
           xaxis = list(title = xaxis_label),
           yaxis = list(title = yaxis_label),
           legend = list(title = list(text = legend_title)))

  fig %>%
    config(displayModeBar = FALSE)

}

rfm_plotly_median <- function(data, bar_color = NULL, sort = FALSE,
                              ascending = FALSE, flip = FALSE,
                              plot_title = NULL, xaxis_label = NULL,
                              yaxis_label = NULL) {

  cnames <- colnames(data)

  ycol <- switch(cnames[2],
                 recency_days   = "Median Recency",
                 transaction_count = "Median Frequency",
                 amount  = "Median Monetary Value"
  )

  text <- paste0("Segment: ", data[[cnames[1]]],
                 " \nMedian Recency: ", data[[cnames[2]]])

  if (is.null(yaxis_label)) {
    yaxis_label <- ycol
  } 

  if (is.null(plot_title)) {
    plot_title <- paste(yaxis_label, " by Segment")
  } 

  if (is.null(xaxis_label)) {
    xaxis_label <- "Segment"
  } 

  if (flip) {
    fig <- plot_ly(data,
                   y = ~segment,
                   x = ~get(cnames[2]),
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
                   y = ~get(cnames[2]),
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

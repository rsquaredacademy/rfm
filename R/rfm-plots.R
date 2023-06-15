#' RFM heatmap
#'
#' @description The heat map shows the average monetary value for different
#'   categories of recency and frequency scores. Higher scores of frequency and
#'   recency are characterized by higher average monetary value as indicated by
#'   the darker areas in the heatmap.
#'
#' @param data An object of class \code{rfm_table}.
#' @param brewer_n Indicates the number of colors in the palette; RColorBrewer
#'   is used for the color palette of the heatmap; check the documentation of
#'   \code{brewer.pal}.
#' @param brewer_name Palette name; check the documentation of
#'   \code{brewer.pal}.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param plot_title Title of the plot.
#' @param legend_title Legend title.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a
#'   plot object.
#'
#' @section Deprecated Functions:
#' \code{rfm_heatmap()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_heatmap()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map
#' # ggplot2
#' rfm_plot_heatmap(rfm_order)
#'
#' # plotly
#' rfm_plot_heatmap(rfm_order, interactive = TRUE)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # heat map
#' rfm_plot_heatmap(rfm_customer)
#'
#' @export
#'
rfm_plot_heatmap <- function(data, brewer_n = 5, brewer_name = "PuBu",
                             xaxis_label = NULL, yaxis_label = NULL,
                             plot_title = NULL, legend_title = NULL,
                             interactive = FALSE, print_plot = TRUE) {

  mapdata <- rfm_heatmap_data(rfm_table = data)

  if (is.null(legend_title)) {
    legend_title <- "Mean Monetary Value"
  }

  if (is.null(plot_title)) {
    plot_title <- "RFM Heat Map"
  }

  if (is.null(xaxis_label)) {
    xaxis_label <- "Frequency Score"
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- "Recency Score"
  }

  if (interactive) {
    rfm_plotly_heatmap(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n,
                       brewer_name, legend_title)
  } else {
    rfm_gg_heatmap(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n,
                   brewer_name, legend_title, print_plot)
  }

}

#' @export
#' @rdname rfm_plot_heatmap
#' @usage NULL
#'
rfm_heatmap <- function(data, plot_title = "RFM Heat Map",
                        xaxis_title = "Frequency",
                        yaxis_title = "Recency",
                        legend_title = "Mean Monetary Value",
                        brewer_n = 5, brewer_name = "PuBu",
                        print_plot = TRUE) {
  .Deprecated("rfm_plot_heatmap()")
  rfm_plot_heatmap(data, plot_title = plot_title,
                        xaxis_label = xaxis_title,
                        yaxis_label = yaxis_title,
                        legend_title = legend_title,
                        brewer_n = brewer_n, brewer_name = brewer_name,
                        print_plot = print_plot)
}


#' RFM histograms
#'
#' Histograms of recency, frequency and monetary value.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param metric Metric to be visualized. Defaults to \code{"recency"}. Valid
#'  values are:
#' \itemize{
#' \item \code{"recency"}
#' \item \code{"frequency"}
#' \item \code{"monetary"}
#' }
#' @param hist_bins Number of bins of the histograms.
#' @param hist_color Color of the histogram.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a
#' plot object.
#'
#' @return Histograms
#'
#' @section Deprecated Functions:
#' \code{rfm_histograms()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_histogram()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # histogram
#' # ggplot2
#' rfm_plot_histogram(rfm_order, metric = "frequency")
#'
#' # plotly
#' rfm_plot_histogram(rfm_order, metric = "frequency", interactive = TRUE)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # histogram
#' rfm_plot_histogram(rfm_customer)
#'
#' @export
#'
rfm_plot_histogram <- function(rfm_table, metric = "recency",
                               hist_bins = 9, hist_color = NULL,
                               plot_title = NULL, xaxis_label = NULL,
                               yaxis_label = NULL, interactive = FALSE,
                               print_plot = TRUE) {

  if (is.null(xaxis_label)) {
    xaxis_label <- to_title_case(metric)
    if (grepl("Monetary", xaxis_label)) {
      xaxis_label <- paste(xaxis_label, "Value")
    }
  }

  if (is.null(plot_title)) {
    plot_title <- paste(xaxis_label, " Distribution")
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- "Count"
  }

  if (is.null(hist_color)) {
    hist_color <- "blue"
  }

  ycol <- switch(metric,
                   "recency"   = "recency_days",
                   "frequency" = "transaction_count",
                   "monetary"  = "amount"
  )

  data <- rfm_table$rfm[, ycol, drop = FALSE]
  names(data) <- c("score")

  if (interactive) {
    rfm_plotly_hist(data, hist_color, plot_title, xaxis_label, yaxis_label)
  } else {
    rfm_gg_hist(data, hist_bins, hist_color, plot_title, xaxis_label,
                yaxis_label, print_plot)
  }

}

#' @export
#' @rdname rfm_plot_histogram
#' @usage NULL
#'
rfm_histograms <- function(rfm_table, hist_bins = 9, hist_color = 'blue',
                           plot_title = 'RFM Histograms', xaxis_title = ' ',
                           yaxis_title = 'Count', print_plot = TRUE) {
  .Deprecated("rfm_plot_histograms()")
  rfm_plot_histogram(rfm_table, metric = "recency",
                     hist_bins = hist_bins, hist_color = hist_color,
                     plot_title = plot_title, xaxis_label = xaxis_title,
                     yaxis_label = xaxis_title, interactive = FALSE,
                     print_plot = print_plot)
}


#' RFM bar chart
#'
#' @description Examine the distribution of monetary scores for the different
#'   combinations of frequency and recency scores.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param bar_color Color of the bars.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param sec_xaxis_label Secondary x axis label.
#' @param sec_yaxis_label Secondary y axis label.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Bar chart.
#'
#' @section Deprecated Functions:
#' \code{rfm_bar_chart()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_bar_chart()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # bar chart
#' rfm_plot_bar_chart(rfm_order)
#'
#' @export
#'
rfm_plot_bar_chart <- function(rfm_table, bar_color = NULL,
                               xaxis_label = NULL, sec_xaxis_label = NULL,
                               yaxis_label = NULL, sec_yaxis_label = NULL,
                               print_plot = TRUE) {

  if (is.null(bar_color)) {
    bar_color <- "blue"
  }

  if (is.null(xaxis_label)) {
    xaxis_label <- "Monetary Score"
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- " "
  }

  if (is.null(sec_xaxis_label)) {
    sec_xaxis_label <- "Frequency Score"
  }

  if (is.null(sec_yaxis_label)) {
    sec_yaxis_label <- "Recency Score"
  }

  p <-
    rfm_barchart_data(rfm_table) %>%
    ggplot() +
    geom_bar(aes(x = monetary_score), fill = bar_color) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    ggtitle(sec_xaxis_label) +
    scale_y_continuous(sec.axis = sec_axis(~ ., name = sec_yaxis_label)) +
    facet_grid(recency_score ~ frequency_score) +
    theme(plot.title = element_text(face = "plain", size = 11, hjust = 0.5),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank())

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @export
#' @rdname rfm_plot_bar_chart
#' @usage NULL
#'
rfm_bar_chart <- function(rfm_table, bar_color = 'blue',
                          xaxis_title = 'Monetary Score',
                          sec_xaxis_title = 'Frequency Score',
                          yaxis_title = ' ',
                          sec_yaxis_title = 'Recency Score',
                          print_plot = TRUE) {
  .Deprecated("rfm_plot_bar_chart()")
  rfm_plot_bar_chart(rfm_table, bar_color = bar_color,
                          xaxis_label = xaxis_title,
                          sec_xaxis_label = sec_xaxis_title,
                          yaxis_label = yaxis_title,
                          sec_yaxis_label = sec_yaxis_title,
                          print_plot = print_plot)
}


#' Customers by orders
#'
#' Visualize the distribution of customers across orders.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param bar_color Color of the bars.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis title.
#' @param yaxis_label Y axis title.
#' @param count_size Size of count displayed on top of the bars.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param animate If \code{TRUE}, animates the bars. Defaults to \code{FALSE}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Bar chart.
#'
#' @section Deprecated Functions:
#' \code{rfm_order_dist()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_order_dist()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # order distribution
#' rfm_plot_order_dist(rfm_order)
#'
#' # horizontal bars
#' rfm_plot_order_dist(rfm_order, flip = TRUE)
#'
#' # plotly
#' rfm_plot_order_dist(rfm_order, interactive = TRUE)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # order distribution
#' rfm_plot_order_dist(rfm_customer)
#'
#' @import gganimate gifski
#'
#' @export
#'
rfm_plot_order_dist <- function(rfm_table, flip = FALSE, bar_color = NULL,
                                plot_title = NULL, xaxis_label = NULL,
                                yaxis_label = NULL, count_size = 3,
                                interactive = FALSE, animate = FALSE,
                                print_plot = TRUE) {

  if (is.null(plot_title)) {
    plot_title <- "Customer Distribution by Orders"
  }

  if (is.null(xaxis_label)) {
    xaxis_label <- "Orders"
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- "Customers"
  }

  if (is.null(bar_color)) {
    bar_color <- "blue"
  }

  data <- rfm_order_dist_data(rfm_table)
  ylim_max <- rfm_order_dist_ylim(data)

  if (interactive) {
    rfm_plotly_order_dist(data, flip = flip, bar_color = bar_color,
                          plot_title = plot_title, xaxis_label = xaxis_label,
                          yaxis_label = yaxis_label)
  } else {

    if (animate) {
      print_plot <- FALSE
      data <- data_animate_order_dist(data)
    }

    p <- rfm_gg_order_dist(data, flip, bar_color, plot_title, xaxis_label, yaxis_label, ylim_max, count_size)

    if (animate) {
      p <- rfm_animate_order_dist(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' @export
#' @rdname rfm_plot_order_dist
#' @usage NULL
#'
rfm_order_dist <- function(rfm_table, bar_color = 'blue',
                           xaxis_title = 'Orders', yaxis_title = 'Customers',
                           plot_title = 'Customers by Orders',
                           print_plot = TRUE) {
  .Deprecated("rfm_plot_order_dist()")
  rfm_plot_order_dist(rfm_table, bar_color = bar_color,
                           xaxis_label = xaxis_title, yaxis_label = yaxis_title,
                           plot_title = plot_title,
                           print_plot = print_plot)
}


#' RFM Scatter plot
#'
#' @description Examine the relationship between recency, frequency
#'   and monetary values.
#'
#' @param segments Output from \code{rfm_segment}.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param plot_title Title of the plot.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Scatter plot.
#'
#' @section Deprecated Functions:
#' \code{rfm_rm_plot()}, \code{rfm_fm_plot()} and \code{rfm_rf_plot()} have
#' been deprecated and will be made defunct. These functions have been provided
#' for compatibility with older versions only, and will be made defunct at the
#' next release.
#' Instead use the replacement function \code{rfm_plot_segment_scatter()()}.
#'
#' @export
#'
rfm_rm_plot <- function(segments, xaxis_label = NULL,
                        yaxis_label = NULL, plot_title = NULL,
                        print_plot = TRUE) {

  .Deprecated("rfm_plot_scatter")
  rfm_plot_segment_scatter(segments, "monetary", "recency", xaxis_label,
                   yaxis_label, plot_title, print_plot)

}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_fm_plot <- function(segments, xaxis_label = NULL,
                        yaxis_label = NULL, plot_title = NULL,
                        print_plot = TRUE) {

  .Deprecated("rfm_plot_scatter")
  rfm_plot_segment_scatter(segments, "monetary", "frequency", xaxis_label,
                   yaxis_label, plot_title, print_plot)

}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_rf_plot <- function(segments, xaxis_label = NULL,
                        yaxis_label = NULL, plot_title = NULL,
                        print_plot = TRUE) {

  .Deprecated("rfm_plot_scatter")
  rfm_plot_segment_scatter(segments, "frequency", "recency", xaxis_label,
                   yaxis_label, plot_title, print_plot)

}

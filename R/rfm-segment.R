#' Segmentation
#'
#' Create segments based on recency, frequency and monetary scores.
#'
#' @param data An object of class \code{rfm_table}.
#' @param segment_names Names of the segments.
#' @param recency_lower Lower boundary for recency score.
#' @param recency_upper Upper boundary for recency score.
#' @param frequency_lower Lower boundary for frequency score.
#' @param frequency_upper Upper boundary for frequency score.
#' @param monetary_lower Lower boundary for monetary score.
#' @param monetary_upper Upper boundary for monetary score.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' rfm_segment(rfm_result, segment_names, recency_lower, recency_upper,
#' frequency_lower, frequency_upper, monetary_lower, monetary_upper)
#'
#'@export
#'
rfm_segment <- function(data, segment_names = NULL, recency_lower = NULL,
                        recency_upper = NULL, frequency_lower = NULL,
                        frequency_upper = NULL, monetary_lower = NULL,
                        monetary_upper = NULL) {

  customer_id <- NULL
  segment <- NULL

  rfm_score_table <- data$rfm
  rfm_score_table$segment <- 1

  n_segments <- length(segment_names)

  for (i in seq_len(n_segments)) {
    rfm_score_table$segment[(
      (rfm_score_table$recency_score %>% between(recency_lower[i], recency_upper[i])) &
        (rfm_score_table$frequency_score %>% between(frequency_lower[i], frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% between(monetary_lower[i], monetary_upper[i])) &
        !rfm_score_table$segment %in% segment_names)] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"
  rfm_score_table$segment[rfm_score_table$segment == 1]   <- "Others"

  rfm_score_table[c("customer_id", "segment", "rfm_score", "transaction_count", "recency_days",
                    "amount", "recency_score", "frequency_score", "monetary_score")]


}

#' Segment summary
#'
#' An overview of customer segments.
#'
#' @param segments Output from \code{rfm_segment}.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # segment summary
#' rfm_segment_summary(segments)
#'
#' @export
#'
rfm_segment_summary <- function(segments) {

  result <-
    segments %>%
    data.table() %>%
    .[, .(customers = .N,
          orders = sum(transaction_count),
          revenue = sum(amount)),
      by = segment] %>%
    setDF()

  result$aov <- result$revenue / result$orders
  return(result)

}

#' Visulaize segment summary
#'
#' Generates plots for customers, orders, revenue and average order value for
#'   each segment.
#'
#' @param x An object of class \code{rfm_segment_summary}.
#' @param metric Metric to be visualized. Defaults to \code{"customers"}. Valid
#'  values are:
#' \itemize{
#' \item \code{"customers"}
#' \item \code{"orders"}
#' \item \code{"revenue"}
#' \item \code{"aov"}
#' }
#' @param bar_color Color of the bars.
#' @param angle Angle at which X axis tick labels should be displayed.
#' @param size Size of X axis tick labels.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param animate If \code{TRUE}, animates the bars. Defaults to \code{FALSE}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a
#'   plot object.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # segment summary
#' segment_overview <- rfm_segment_summary(segments)
#'
#' # plot segment summary
#' # summarize metric for all segments
#' # ggplot2
#' rfm_plot_segment_summary(segment_overview)
#'
#' # plotly
#' rfm_plot_segment_summary(segment_overview, interactive = TRUE)
#'
#' # select metric to be visualized
#' rfm_plot_segment_summary(segment_overview, metric = "orders")
#'
#' # sort the metric in ascending order
#' rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE,
#'   ascending = TRUE)
#'
#' # default sorting is in descending order
#' rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE)
#'
#' # horizontal bars
#' rfm_plot_segment_summary(segment_overview, metric = "orders", flip = TRUE)
#'
#' @export
#'
rfm_plot_segment_summary <- function(x, metric = NULL, bar_color = NULL,
                                     angle = 90, size = 5, sort = FALSE,
                                     ascending = FALSE, flip = FALSE,
                                     plot_title = NULL, xaxis_label = NULL,
                                     yaxis_label = NULL, interactive = FALSE,
                                     animate = FALSE, print_plot = TRUE) {

  if (is.null(metric)) {
    metric <- "customers"
  }

  if (is.null(bar_color)) {
    bar_color <- "blue"
  }

  if (is.null(plot_title)) {
    plot_title <- paste(to_title_case(metric), " Distribution by Segment")
  }

  if (is.null(xaxis_label)) {
    xaxis_label <- "Segment"
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- to_title_case(metric)
  }

  data <- x[c("segment", metric)]
  ylim_max <-
    data[[metric]] %>%
    max() %>%
    multiply_by(1.15) %>%
    ceiling(.)

  if (interactive) {
    rfm_plotly_segment_summary(data, metric, flip, sort, ascending, bar_color,
                               plot_title, xaxis_label, yaxis_label)
  } else {
    if (animate) {
      print_plot <- FALSE
      data <- data_animate_segment_summary(data, metric)
    }

    p <- rfm_gg_plot_segment_summary(data, metric, sort, ascending, flip,
                                        bar_color, plot_title, xaxis_label,
                                        yaxis_label, angle, size, ylim_max)

    if (animate) {
      p <- rfm_animate_segment_summary(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' Revenue distribution
#'
#' Customer and revenue distribution by segments.
#'
#' @param x An object of class \code{rfm_segment_summary}.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param angle Angle at which X axis tick labels should be displayed.
#' @param size Size of X axis tick labels.
#' @param colors Bar colors.
#' @param labels Legend labels.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param animate If \code{TRUE}, animates the bars. Defaults to \code{FALSE}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # segment summary
#' segment_overview <- rfm_segment_summary(segments)
#'
#' # revenue distribution
#' # ggplot2
#' rfm_plot_revenue_dist(segment_overview)
#'
#' # flip
#' rfm_plot_revenue_dist(segment_overview, flip = TRUE)
#'
#' # plotly
#' rfm_plot_revenue_dist(segment_overview, interactive = TRUE)
#'
#' @export
#'
rfm_plot_revenue_dist <- function(x, flip = FALSE, angle = 315, size = 6,
                                  colors = c("#3b5bdb", "#91a7ff"),
                                  labels = c("Revenue", "Customers"),
                                  plot_title = "Revenue & Customer Distribution",
                                  xaxis_label = NULL, yaxis_label = NULL,
                                  interactive = FALSE, animate = FALSE,
                                  print_plot = TRUE) {

  data <- rfm_prep_revenue_dist(x)

  if (interactive) {
    rfm_plotly_revenue_dist(x, flip, colors, labels, plot_title, xaxis_label,
                            yaxis_label)
  } else {

    if (animate) {
      print_plot <- FALSE
      data <- data_animate_revenue_dist(data)
    }

    p <- rfm_gg_revenue_dist(data, colors, labels, flip, angle, size, plot_title,
                             xaxis_label, yaxis_label)

    if (animate) {
      p <- rfm_animate_revenue_dist(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' Segmentation plots
#'
#' Segment wise median recency, frequency & monetary value plot.
#'
#' @param rfm_segment_table Output from \code{rfm_segment}.
#' @param color Color of the bars.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param font_size Font size for X axis text.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param animate If \code{TRUE}, animates the bars. Defaults to \code{FALSE}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # plots
#' # visualize median recency
#' rfm_plot_median_recency(segments)
#'
#' # plotly
#' rfm_plot_median_recency(segments, interactive = TRUE)
#'
#' # sort in ascending order
#' rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE)
#'
#' # default sorting is in descending order
#' rfm_plot_median_recency(segments, sort = TRUE)
#'
#' # horizontal bars
#' rfm_plot_median_recency(segments, flip = TRUE)
#'
#' # median frequency
#' rfm_plot_median_frequency(segments)
#'
#' # median monetary value
#' rfm_plot_median_monetary(segments)
#'
#' @export
#'
rfm_plot_median_recency <- function(rfm_segment_table, color = "blue",
                                    sort = FALSE, ascending = FALSE,
                                    flip = FALSE, plot_title = NULL,
                                    xaxis_label = NULL, yaxis_label = NULL,
                                    font_size = 6, interactive = FALSE,
                                    animate = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, recency_days)

  if (interactive) {
    rfm_plotly_median(data, color, sort, ascending, flip, plot_title,
                      xaxis_label, yaxis_label)
  } else {

    if (animate) {
      print_plot <- FALSE
      data <- data_animate_median_recency(data)
    }

    p <- rfm_plot_median(data, color, sort, ascending, flip, plot_title,
                         xaxis_label, yaxis_label, font_size)

    if (animate) {
      p <- rfm_animate_median_recency(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }


}

#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_frequency <- function(rfm_segment_table, color = "blue",
                                      sort = FALSE, ascending = FALSE,
                                      flip = FALSE, plot_title = NULL,
                                      xaxis_label = NULL, yaxis_label = NULL,
                                      font_size = 6, interactive = FALSE,
                                      animate = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, transaction_count)

  if (interactive) {
    rfm_plotly_median(data, color, sort, ascending, flip, plot_title,
                      xaxis_label, yaxis_label)
  } else {
    if (animate) {
      print_plot <- FALSE
      data <- data_animate_median_frequency(data)
    }

    p <- rfm_plot_median(data, color, sort, ascending, flip, plot_title,
                         xaxis_label, yaxis_label, font_size)

    if (animate) {
      p <- rfm_animate_median_frequency(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}


#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_monetary <- function(rfm_segment_table, color = "blue",
                                     sort = FALSE, ascending = FALSE,
                                     flip = FALSE, plot_title = NULL,
                                     xaxis_label = NULL, yaxis_label = NULL,
                                     font_size = 6, interactive = FALSE,
                                     animate = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, amount)

  if (interactive) {
    rfm_plotly_median(data, color, sort, ascending, flip, plot_title,
                      xaxis_label, yaxis_label)
  } else {
    if (animate) {
      print_plot <- FALSE
      data <- data_animate_median_monetary(data)
    }

    p <- rfm_plot_median(data, color, sort, ascending, flip, plot_title,
                         xaxis_label, yaxis_label, font_size)

    if (animate) {
      p <- rfm_animate_median_monetary(p)
      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' RFM Segmentation Plot
#'
#' Generates tree map to visualize segments.
#'
#' @param table An object of class \code{rfm_segment_summary}.
#' @param metric Metric to be visualized. Defaults to \code{"customers"}. Valid
#' values are:
#' \itemize{
#' \item \code{"customers"}
#' \item \code{"orders"}
#' \item \code{"revenue"}
#' }
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # segment summary
#' segment_overview <- rfm_segment_summary(segments)
#'
#' # treemaps
#' # default metric is customers
#' rfm_plot_segment(segment_overview)
#'
#' # treemap of orders
#' rfm_plot_segment(segment_overview, metric = "orders")
#'
#' # plotly
#' rfm_plot_segment(segment_overview, metric = "revenue", interactive = TRUE)
#'
#' @import treemapify
#' @export
#'
rfm_plot_segment <- function(table, metric = "customers", interactive = FALSE,
                             print_plot = TRUE) {

  table$prop <- round((table[[metric]] / sum(table[[metric]])) * 100, 2)

  if (interactive) {
    rfm_plotly_segment(table, metric)
  } else {
    rfm_gg_segment(table, metric, print_plot)
  }

}

#' Segment Scatter Plots
#'
#' @description Generate scatter plots to examine the relationship between
#' recency, frequency and monetary value.
#'
#' @param segments Output from \code{rfm_segment}.
#' @param x Metric to be represented on X axis.
#' @param y Metric to be represented on Y axis.
#' @param plot_title Title of the plot.
#' @param legend_title Title of the plot legend.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param animate If \code{TRUE}, animates the bars. Defaults to \code{FALSE}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a
#'   plot object.
#'
#' @return Scatter plot.
#'
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # visualize
#' # ggplot2
#' rfm_plot_segment_scatter(segments, "monetary", "recency")
#'
#' # plotly
#' rfm_plot_segment_scatter(segments, "monetary", "recency", interactive = TRUE)
#'
#' @export
rfm_plot_segment_scatter <- function(segments, x = "monetary", y = "recency",
                                     plot_title = NULL, legend_title = NULL,
                                     xaxis_label = NULL, yaxis_label = NULL,
                                     interactive = FALSE, animate = FALSE,
                                     print_plot = TRUE) {

  x_data <- switch(x,
                   "recency" = "recency_days",
                   "frequency" = "transaction_count",
                   "monetary" = "amount"
  )

  y_data <- switch(y,
                   "recency" = "recency_days",
                   "frequency" = "transaction_count",
                   "monetary" = "amount"
  )

  if (is.null(xaxis_label)) {
    xaxis_label <- to_title_case(x)
    if (grepl("Monetary", xaxis_label)) {
      xaxis_label <- paste(xaxis_label, "Value")
    }
  }

  if (is.null(yaxis_label)) {
    yaxis_label <- to_title_case(y)
    if (grepl("Monetary", yaxis_label)) {
      yaxis_label <- paste(yaxis_label, "Value")
    }
  }

  if (is.null(plot_title)) {
    plot_title <- paste(yaxis_label, "vs", xaxis_label)
  }

  if (interactive) {
    rfm_plotly_segment_scatter(segments, x_data, y_data, plot_title,
                               legend_title, xaxis_label, yaxis_label)
  } else {
    p <- rfm_gg_segment_scatter(segments, x_data, y_data, plot_title,
                                legend_title, xaxis_label, yaxis_label)

    if (animate) {
      print_plot <- FALSE
      p <-
        p +
        transition_reveal(along = rfm_score)

      animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

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
#' @param package Visualization engine. Choose between \code{ggplot2}
#'   and \code{plotly}.
#' @param bar_color Color of the bars.
#' @param angle Angle at which X axis tick labels should be displayed.
#' @param size Size of X axis tick labels.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
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
#' rfm_plot_segment_summary(segment_overview)
#'
#' # select metric to be visualized
#' rfm_plot_segment_summary(segment_overview, metric = "orders")
#'
#' # sort the metric in ascending order
#' rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE, ascending = TRUE)
#'
#' # default sorting is in descending order
#' rfm_plot_segment_summary(segment_overview, metric = "orders", sort = TRUE)
#'
#' # horizontal bars
#' rfm_plot_segment_summary(segment_overview, metric = "orders", flip = TRUE)
#'
#' @export
#'
rfm_plot_segment_summary <- function(x, metric = NULL, package = c("ggplot2", "plotly"), bar_color = NULL,
                                     angle = 90, size = 5,
                                     sort = FALSE, ascending = FALSE,
                                     flip = FALSE, plot_title = NULL,
                                     xaxis_label = NULL, yaxis_label = NULL,
                                     print_plot = TRUE) {

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
  lib <- match.arg(package)

  if (lib == "ggplot2") {
    rfm_gg_plot_segment_summary(data, metric, sort, ascending, flip, bar_color, plot_title, xaxis_label, yaxis_label, angle, size, print_plot)
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
#' # visualize revenue distribution
#' rfm_plot_revenue_dist(segment_overview)
#'
#' @export
#'
rfm_plot_revenue_dist <- function(x, flip = FALSE, angle = 90, size = 8,
                                  colors = c("#3b5bdb", "#91a7ff"),
                                  labels = c("Revenue", "Customers"),
                                  plot_title = "Revenue & Customer Distribution",
                                  print_plot = TRUE) {

  data <- rfm_prep_revenue_dist(x)

  p <-
    ggplot(data, aes(fill = category, y = share, x = segment)) +
    geom_bar(position="dodge", stat="identity")

  p <-
    p +
    scale_fill_manual(values = c(colors[1], colors[2]),
                      labels = c(labels[1], labels[2])) +
    scale_y_continuous(labels = scales::percent)

  p <-
    p +
    theme(legend.title = element_blank(),
          legend.position = "bottom",
          panel.background = element_rect(fill = NA),
          axis.ticks = element_line(color = NA))

  if (flip) {
    p <-
      p +
      theme(panel.grid.major.x = element_line(colour = "#ced4da")) +
      coord_flip()
  } else {
    p <-
      p +
      theme(panel.grid.major.y = element_line(colour = "#ced4da"),
            axis.text.x = element_text(angle = angle, vjust = 1,
                                       hjust=1, size = size))
  }

  p <-
    p +
    xlab("") +
    ylab("") +
    ggtitle(plot_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

rfm_prep_revenue_dist <- function(x) {

  x$customer_share <- x$customers / sum(x$customers)
  x$revenue_share <- x$revenue / sum(x$revenue)
  data <- x[c("segment", "customer_share", "revenue_share")]

  n_row    <- nrow(data)
  segment  <- rep(data$segment, each = 2)
  category <- rep(c("customer_share", "revenue_share"), times = n_row)

  share <- c()
  for (i in seq_len(n_row)) {
    y <- as.numeric(data[i, c(2, 3)])
    share <- c(share, y)
  }

  result <- data.frame(segment, category, share)
  result$category <- factor(result$category, levels = c("revenue_share", "customer_share"))
  return(result)
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
#' @param font_size Font size for X axis text.
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
rfm_plot_median_recency <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, recency_days)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_frequency <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, transaction_count)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}


#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_monetary <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, amount)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

rfm_prep_median <- function(rfm_segment_table, metric) {

  met <- deparse(substitute(metric))

  result <-
    rfm_segment_table %>%
    data.table() %>%
    .[, .(segment, met = get(met))] %>%
    .[, .(mem = median(met)), by = segment] %>%
    .[order(mem)] %>%
    setnames(old = "mem", new = met) %>%
    setDF()

  return(result)

}

rfm_plot_median <- function(data, color, font_size, sort, ascending, flip) {

  n_fill <- nrow(data)
  cnames <- names(data)
  y_lab  <-
    switch(cnames[2],
           recency_days = "Median Recency",
           transaction_count = "Median Frequency",
           amount = "Median Monetary Value")

  if (sort) {
    if (ascending) {
      if (flip) {
        p <- ggplot(data, aes(x = reorder(.data[[cnames[1]]], -.data[[cnames[2]]], sum), y = .data[[cnames[2]]]))
      } else {
        p <- ggplot(data, aes(x = reorder(.data[[cnames[1]]], .data[[cnames[2]]], sum), y = .data[[cnames[2]]]))
      }
    } else {
      if (flip) {
        p <- ggplot(data, aes(x = reorder(.data[[cnames[1]]], .data[[cnames[2]]], sum), y = .data[[cnames[2]]]))
      } else {
        p <- ggplot(data, aes(x = reorder(.data[[cnames[1]]], -.data[[cnames[2]]], sum), y = .data[[cnames[2]]]))
      }
    }
  } else {
    p <- ggplot(data, aes(x = .data[[cnames[1]]], y = .data[[cnames[2]]]))
  }


  p <-
    p +
    geom_bar(stat = "identity", fill = color) +
    ggtitle(paste(y_lab, "by Segment")) +
    theme(plot.title = element_text(hjust = 0.5))

  if (flip) {
    p <-
      p +
      coord_flip() +
      xlab(y_lab) +
      ylab("Segment") +
      theme(axis.text.y = element_text(size = font_size))
  } else {
    p <-
      p +
      xlab("Segment") +
      ylab(y_lab) +
      theme(axis.text.x = element_text(size = font_size))
  }

  return(p)

}

#' RFM Segmentation Plot
#'
#' Generates tree map to visualize segments.
#'
#' @param table An object of class \code{rfm_segment_summary}.
#' @param metric Metric to be visualized. Defaults to \code{"customers"}. Valid
#' values are:
#' \itemize{
#' \item \code{"orders"}
#' \item \code{"revenue"}
#' }
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
#' # treemap of revenue
#' rfm_plot_segment(segment_overview, metric = "revenue")
#'
#' @import treemapify
#' @export
#'
rfm_plot_segment <- function(table, metric = "customers", print_plot = TRUE) {

  table$prop <- round((table[[metric]] / sum(table[[metric]])) * 100, 2)
  plot <- ggplot(table,
          aes(area = .data[[metric]],
             fill = segment,
             label = paste(toupper(segment),
                           paste0(.data[[metric]], " (", prop, "%)"),
                           sep = '\n'))) +
    geom_treemap() +
    geom_treemap_text(size = 8, place = 'centre') +
    theme(legend.position = "none")

    if (print_plot) {
    print(plot)
  } else {
    return(plot)
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
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param plot_title Title of the plot.
#' @param legend_title Title of the plot legend.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
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
#' # generate plots
#' rfm_plot_segment_scatter(segments, "monetary", "recency")
#' rfm_plot_segment_scatter(segments, "monetary", "frequency")
#' rfm_plot_segment_scatter(segments, "frequency", "recency")
#'
#' @export
rfm_plot_segment_scatter <- function(segments, x = "monetary", y = "recency",
                             xaxis_label = NULL, yaxis_label = NULL,
                             plot_title = NULL, legend_title = NULL, print_plot = TRUE) {

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
    x_label <- to_title_case(x)
    if (grepl("Monetary", x_label)) {
      x_label <- paste(x_label, "Value")
    }
  } else {
    x_label <- xaxis_label
  }

  if (is.null(yaxis_label)) {
    y_label <- to_title_case(y)
    if (grepl("Monetary", y_label)) {
      y_label <- paste(y_label, "Value")
    }
  } else {
    y_label <- yaxis_label
  }

  if (is.null(plot_title)) {
    plot_title <- paste(y_label, "vs", x_label)
  } else {
    plot_title <- plot_title
  }

  p <- rfm_plot_combine(segments, x_data, y_data, x_label, y_label, plot_title, legend_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

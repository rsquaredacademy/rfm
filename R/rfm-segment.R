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
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' segments
#'
#' @importFrom dplyr between
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
      (rfm_score_table$recency_score %>% between(recency_lower[i],
                                                 recency_upper[i])) &
        (rfm_score_table$frequency_score %>% between(frequency_lower[i],
                                                     frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% between(monetary_lower[i],
                                                    monetary_upper[i])) &
        !rfm_score_table$segment %in% segment_names)] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"
  rfm_score_table$segment[rfm_score_table$segment == 1]   <- "Others"

  rfm_score_table[c("customer_id", "segment", "rfm_score", "transaction_count",
                    "recency_days", "amount", "recency_score",
                    "frequency_score", "monetary_score")]


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

  segments %>%
    group_by(segment) %>%
    summarise(
      customers = n(),
      orders = sum(transaction_count),
      revenue = sum(amount)
    ) %>%
    mutate(aov = round((revenue / orders), 2))

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
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param bar_color Color of the bars.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param axis_label_size Font size of X axis tick labels.
#' @param axis_label_angle Angle of X axis tick labels.
#' @param bar_labels If \code{TRUE}, add labels to the bars. Defaults to
#'   \code{TRUE}.
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
rfm_plot_segment_summary <- function(x, metric = NULL,  sort = FALSE,
                                     ascending = FALSE, flip = FALSE,
                                     bar_color = NULL, plot_title = NULL,
                                     xaxis_label = NULL, yaxis_label = NULL,
                                     axis_label_size = 8, axis_label_angle = 315,
                                     bar_labels = TRUE, interactive = FALSE,
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

  if (interactive) {
    animate <- FALSE
  }

  data <- x[c("segment", metric)]
  ylim_max <-
    data[[metric]] %>%
    max() %>%
    multiply_by(1.15) %>%
    ceiling(.)

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_segment_summary(data, metric, flip, sort, ascending, bar_color,
                                 plot_title, xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_segment_summary(data, metric, flip, sort, ascending, bar_color,
                                     plot_title, xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_segment_summary(data, metric, sort, ascending, flip,
                                    bar_color, plot_title, xaxis_label,
                                    yaxis_label, axis_label_size, axis_label_angle,
                                    ylim_max, bar_labels)
      }
    }
  } else {
    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        data <- rfm_animate_data(data, metric)
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            data <- rfm_animate_data(data, metric)
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    p <- rfm_gg_segment_summary(data, metric, sort, ascending, flip,
                                bar_color, plot_title, xaxis_label,
                                yaxis_label, axis_label_size, axis_label_angle,
                                ylim_max, bar_labels)

    if (animate) {
      p <- rfm_animate_plot(p)
      gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
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
#' @param colors Bar colors.
#' @param legend_labels Legend labels.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param axis_label_size Font size of X axis tick labels.
#' @param axis_label_angle Angle of X axis tick labels.
#' @param bar_labels If \code{TRUE}, add labels to the bars. Defaults to
#'   \code{FALSE}.
#' @param bar_label_size Size of bar labels.
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
rfm_plot_revenue_dist <- function(x, flip = FALSE,
                                  colors = c("#3b5bdb", "#91a7ff"),
                                  legend_labels = c("Revenue", "Customers"),
                                  plot_title = "Revenue & Customer Distribution",
                                  xaxis_label = NULL, yaxis_label = NULL,
                                  axis_label_size = 8, axis_label_angle = 315,
                                  bar_labels = FALSE, bar_label_size = 2,
                                  interactive = FALSE, animate = FALSE,
                                  print_plot = TRUE) {

  if (interactive) {
    animate <- FALSE
  }

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_revenue_dist(x, flip, colors, legend_labels, plot_title,
                              xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_revenue_dist(x, flip, colors, legend_labels, plot_title,
                                  xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_revenue_dist(data, colors, legend_labels, flip,
                                 plot_title, xaxis_label, yaxis_label,
                                 axis_label_size, axis_label_angle,
                                 bar_labels, bar_label_size)
      }
    }
  } else {

    data <- rfm_prep_revenue_dist(x)
    share_data <- data[, c("category"), drop = FALSE]

    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        bar_labels <- FALSE
        data <- rfm_animate_data(data, "share")
        data$category <- rep(share_data$category, 10)
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            bar_labels <- FALSE
            data <- rfm_animate_data(data, "share")
            data$category <- rep(share_data$category, 10)
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    p <- rfm_gg_revenue_dist(data, colors, legend_labels, flip,
                             plot_title, xaxis_label, yaxis_label,
                             axis_label_size, axis_label_angle,
                             bar_labels, bar_label_size)

    if (animate) {
      p <- rfm_animate_plot(p)
      gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' Median plots
#'
#' Segment wise median recency, frequency & monetary value plot.
#'
#' @param rfm_segment_table Output from \code{rfm_segment}.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param bar_color Color of the bars.
#' @param plot_title Title of the plot.
#' @param xaxis_label X axis label.
#' @param yaxis_label Y axis label.
#' @param axis_label_size Font size of X axis tick labels.
#' @param axis_label_angle Angle of X axis tick labels.
#' @param bar_labels If \code{TRUE}, add labels to the bars. Defaults to
#'   \code{TRUE}.
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
rfm_plot_median_recency <- function(rfm_segment_table, sort = FALSE,
                                    ascending = FALSE, flip = FALSE,
                                    bar_color = NULL, plot_title = NULL,
                                    xaxis_label = NULL, yaxis_label = NULL,
                                    axis_label_size = 8, axis_label_angle = 315,
                                    bar_labels = TRUE, interactive = FALSE,
                                    animate = FALSE, print_plot = TRUE) {

  if (interactive) {
    animate <- FALSE
  }

  data <- rfm_prep_median(rfm_segment_table, recency_days)

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                        xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                            xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                           xaxis_label, yaxis_label, axis_label_size,
                           axis_label_angle, bar_labels)
      }
    }
  } else {

    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        data <- rfm_animate_data(data, "recency_days")
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            data <- rfm_animate_data(data, "recency_days")
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                       xaxis_label, yaxis_label, axis_label_size,
                       axis_label_angle, bar_labels)

    if (animate) {
      p <- rfm_animate_plot(p)
      gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
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
rfm_plot_median_frequency <- function(rfm_segment_table, sort = FALSE,
                                      ascending = FALSE, flip = FALSE,
                                      bar_color = NULL, plot_title = NULL,
                                      xaxis_label = NULL, yaxis_label = NULL,
                                      axis_label_size = 8,
                                      axis_label_angle = 315,
                                      bar_labels = TRUE, interactive = FALSE,
                                      animate = FALSE, print_plot = TRUE) {

  if (interactive) {
    animate <- FALSE
  }

  data <- rfm_prep_median(rfm_segment_table, transaction_count)

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                        xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                            xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                           xaxis_label, yaxis_label, axis_label_size,
                           axis_label_angle, bar_labels)
      }
    }
  } else {

    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        data <- rfm_animate_data(data, "transaction_count")
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            data <- rfm_animate_data(data, "transaction_count")
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                       xaxis_label, yaxis_label, axis_label_size,
                       axis_label_angle, bar_labels)

    if (animate) {
      p <- rfm_animate_plot(p)
      gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
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
rfm_plot_median_monetary <- function(rfm_segment_table, sort = FALSE,
                                     ascending = FALSE, flip = FALSE,
                                     bar_color = NULL, plot_title = NULL,
                                     xaxis_label = NULL, yaxis_label = NULL,
                                     axis_label_size = 8,
                                     axis_label_angle = 315,
                                     bar_labels = TRUE, interactive = FALSE,
                                     animate = FALSE, print_plot = TRUE) {

  if (interactive) {
    animate <- FALSE
  }

  data <- rfm_prep_median(rfm_segment_table, amount)

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                        xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_median(data, bar_color, sort, ascending, flip, plot_title,
                            xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                           xaxis_label, yaxis_label, axis_label_size,
                           axis_label_angle, bar_labels)
      }
    }
  } else {

    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        data <- rfm_animate_data(data, "amount")
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            data <- rfm_animate_data(data, "amount")
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    p <- rfm_gg_median(data, bar_color, sort, ascending, flip, plot_title,
                       xaxis_label, yaxis_label, axis_label_size, axis_label_angle,
                       bar_labels)

    if (animate) {
      p <- rfm_animate_plot(p)
      gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
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
#' @export
#'
rfm_plot_segment <- function(table, metric = "customers", interactive = FALSE,
                             print_plot = TRUE) {

  table$prop <- round((table[[metric]] / sum(table[[metric]])) * 100, 2)

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_segment(table, metric)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_segment(table, metric)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_segment(table, metric, print_plot)
      }
    }
  } else {
    p <- rfm_gg_segment(table, metric, print_plot)
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
    animate <- FALSE
  }

  if (interactive) {
    pkg_flag <- requireNamespace("plotly", quietly = TRUE)
    if (pkg_flag) {
      rfm_plotly_segment_scatter(segments, x_data, y_data, plot_title,
                                 legend_title, xaxis_label, yaxis_label)
    } else {
      if (interactive()) {
        message('`plotly` must be installed for this functionality. Would you like to install?')
        if (menu(c("Yes", "No")) == 1) {
          install.packages("plotly")
          rfm_plotly_segment_scatter(segments, x_data, y_data, plot_title,
                                     legend_title, xaxis_label, yaxis_label)
        } else {
          stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
        }
      } else {
        warning("`plot` is not installed. Using `ggplot2` instead to generate the plot!")
        p <- rfm_gg_segment_scatter(segments, x_data, y_data, plot_title,
                                    legend_title, xaxis_label, yaxis_label)
      }
    }

  } else {
    p <- rfm_gg_segment_scatter(segments, x_data, y_data, plot_title,
                                legend_title, xaxis_label, yaxis_label)

    if (animate) {
      pkg_flag <- requireNamespace("gganimate", quietly = TRUE)
      if (pkg_flag) {
        print_plot <- FALSE
        p <-
          p +
          gganimate::transition_reveal(along = rfm_score)

        gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
      } else {
        if (interactive()) {
          message('`gganimate` must be installed for this functionality. Would you like to install?')
          if (menu(c("Yes", "No")) == 1) {
            install.packages("gganimate")
            print_plot <- FALSE
            p <-
              p +
              gganimate::transition_reveal(along = rfm_score)

            gganimate::animate(p, fps=8, renderer = gganimate::gifski_renderer(loop = FALSE))
          } else {
            stop('Sorry! The functionality is not available without installing the required package.', call. = FALSE)
          }
        } else {
          animate <- FALSE
          warning("`gganimate` is not installed. Using `ggplot2` instead to generate the plot!")
        }
      }
    }

    if (print_plot) {
      print(p)
    } else {
      return(p)
    }
  }

}

#' RFM heatmap
#'
#' @description The heat map shows the average monetary value for different
#'   categories of recency and frequency scores. Higher scores of frequency and
#'   recency are characterized by higher average monetary value as indicated by
#'   the darker areas in the heatmap.
#'
#' @param data An object of class \code{rfm_table}.
#' @param plot_title Title of the plot.
#' @param plot_title_justify Horizontal justification of the plot title;
#'   0 for left justified and 1 for right justified.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param legend_title Legend title.
#' @param brewer_n Indicates the number of colors in the palette; RColorBrewer
#'   is used for the color palette of the heatmap; check the documentation of
#'   \code{brewer.pal}.
#' @param brewer_name Palette name; check the documentation of
#'   \code{brewer.pal}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @section Deprecated Functions:
#' \code{rfm_heatmap()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_heatmap()()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map
#' rfm_plot_heatmap(rfm_order)
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
rfm_plot_heatmap <- function(data, plot_title = "RFM Heat Map",
                        plot_title_justify = 0.5, xaxis_title = "Frequency",
                        yaxis_title = "Recency",
                        legend_title = "Mean Monetary Value",
                        brewer_n = 5, brewer_name = "PuBu",
                        print_plot = TRUE) {

  mapdata <- rfm_heatmap_data(rfm_table = data)

  ulm <-
    mapdata %>%
    extract2("monetary") %>%
    max() %>%
    ceiling(.)

  llm <-
    mapdata %>%
    extract2("monetary") %>%
    min() %>%
    floor(.)

  bins <-
    mapdata %>%
    use_series(frequency_score) %>%
    max()

  guide_breaks <- round(seq(llm, ulm, length.out = bins))

  p <-
    ggplot(data = mapdata) +
    geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
    ggtitle(plot_title) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    scale_fill_gradientn(limits = c(llm, ulm),
                         colours = RColorBrewer::brewer.pal(n = brewer_n, name = brewer_name),
                         name = legend_title) +
    theme(plot.title = element_text(hjust = plot_title_justify))

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @export
#' @rdname rfm_plot_heatmap
#' @usage NULL
#'
rfm_heatmap <- function(data, plot_title = "RFM Heat Map",
                        plot_title_justify = 0.5, xaxis_title = "Frequency",
                        yaxis_title = "Recency",
                        legend_title = "Mean Monetary Value",
                        brewer_n = 5, brewer_name = "PuBu",
                        print_plot = TRUE) {
  .Deprecated("rfm_plot_heatmap()")
  rfm_plot_heatmap(data, plot_title = "RFM Heat Map",
                        plot_title_justify = 0.5, xaxis_title = "Frequency",
                        yaxis_title = "Recency",
                        legend_title = "Mean Monetary Value",
                        brewer_n = 5, brewer_name = "PuBu",
                        print_plot = TRUE)
}


#' RFM histograms
#'
#' Histograms of recency, frequency and monetary value.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param hist_bins Number of bins of the histograms.
#' @param hist_color Color of the histogram.
#' @param plot_title Title of the plot.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param hist_m_label Label of the monetary value histogram.
#' @param hist_r_label Label of the recency histogram.
#' @param hist_f_label Label of the frequency histogram.
#' @param plot_title_justify Horizontal justification of the plot title;
#'   0 for left justified and 1 for right justified.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Histograms
#'
#' @section Deprecated Functions:
#' \code{rfm_histograms()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_histograms()()}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # histogram
#' rfm_plot_histograms(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # histogram
#' rfm_plot_histograms(rfm_customer)
#'
#' @export
#'
rfm_plot_histograms <- function(rfm_table, hist_bins = 9, hist_color = 'blue',
                           plot_title = 'RFM Histograms', xaxis_title = ' ',
                           yaxis_title = 'Count', hist_m_label = 'Monetary',
                           hist_r_label = 'Recency', hist_f_label = 'Frequency',
                           plot_title_justify = 0.5, print_plot = TRUE) {

  p <-
    rfm_hist_data(rfm_table) %>%
    ggplot(aes(score)) +
    geom_histogram(bins = hist_bins, fill = hist_color) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    ggtitle(plot_title) +
    facet_grid(. ~ rfm, scales = "free_x",
      labeller = labeller(
        rfm = c(amount = hist_m_label, recency_days = hist_r_label,
                transaction_count = hist_f_label))) +
    theme(plot.title = element_text(hjust = plot_title_justify))

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @export
#' @rdname rfm_plot_histograms
#' @usage NULL
#'
rfm_histograms <- function(rfm_table, hist_bins = 9, hist_color = 'blue',
                           plot_title = 'RFM Histograms', xaxis_title = ' ',
                           yaxis_title = 'Count', hist_m_label = 'Monetary',
                           hist_r_label = 'Recency', hist_f_label = 'Frequency',
                           plot_title_justify = 0.5, print_plot = TRUE) {
  .Deprecated("rfm_plot_histograms()")
  rfm_plot_histograms(rfm_table, hist_bins = 9, hist_color = 'blue',
                           plot_title = 'RFM Histograms', xaxis_title = ' ',
                           yaxis_title = 'Count', hist_m_label = 'Monetary',
                           hist_r_label = 'Recency', hist_f_label = 'Frequency',
                           plot_title_justify = 0.5, print_plot = TRUE)
}


#' RFM bar chart
#'
#' @description Examine the distribution of monetary scores for the different
#'   combinations of frequency and recency scores.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param bar_color Color of the bars.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param sec_xaxis_title Secondary x axis title.
#' @param sec_yaxis_title Secondary y axis title.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Bar chart.
#'
#' @section Deprecated Functions:
#' \code{rfm_bar_chart()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_bar_chart()()}.
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
rfm_plot_bar_chart <- function(rfm_table, bar_color = 'blue',
                          xaxis_title = 'Monetary Score',
                          sec_xaxis_title = 'Frequency Score',
                          yaxis_title = ' ',
                          sec_yaxis_title = 'Recency Score',
                          print_plot = TRUE) {

  p <-
    rfm_barchart_data(rfm_table) %>%
    ggplot() +
    geom_bar(aes(x = monetary_score), fill = bar_color) +
    xlab(xaxis_title) +
    ylab(" ") +
    ggtitle(sec_xaxis_title) +
    scale_y_continuous(sec.axis = sec_axis(~ ., name = sec_yaxis_title)) +
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
  rfm_plot_bar_chart(rfm_table, bar_color = 'blue',
                          xaxis_title = 'Monetary Score',
                          sec_xaxis_title = 'Frequency Score',
                          yaxis_title = ' ',
                          sec_yaxis_title = 'Recency Score',
                          print_plot = TRUE)
}


#' Customers by orders
#'
#' Visualize the distribution of customers across orders.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param bar_color Color of the bars.
#' @param animate Logical; if \code{TRUE}, animates the bars.
#'   Defaults to \code{FALSE}.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param count_size Size of count displayed on top of the bars.
#' @param plot_title Title of the plot.
#' @param plot_title_justify Horizontal justification of the plot title;
#'   0 for left justified and 1 for right justified.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Bar chart.
#'
#' @section Deprecated Functions:
#' \code{rfm_order_dist()} has been deprecated and will be made defunct. It has
#' been provided for compatibility with older versions only, and will be made
#' defunct at the next release.
#'
#' Instead use the replacement function \code{rfm_plot_order_dist()()}.
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
rfm_plot_order_dist <- function(rfm_table, bar_color = 'blue',
                                animate = FALSE,
                                xaxis_title = 'Orders',
                                yaxis_title = 'Customers',
                                count_size = 3,
                                plot_title = 'Customers by Orders',
                                plot_title_justify = 0.5,
                                print_plot = TRUE) {

  data <-
    rfm_table %>%
    use_series(rfm) %>%
    data.table() %>%
    .[, .(n = .N), by = transaction_count] %>%
    setDF()

  ylim_max <-
    data %>%
    use_series(n) %>%
    max() %>%
    multiply_by(1.1) %>%
    ceiling(.)

  if (animate) {
    print_plot <- FALSE
    n_groups <- length(data$n)

    gap <- data$n / 9
    start <- rep(0, n_groups)
    value <- start
    for (i in seq_len(9)) {
      n <- start + gap
      value <- c(value, n)
      start <- n
    }


    data <- data.frame(transaction_count = rep(data$transaction_count, 10),
                       n = round(value),
                       frame = rep(letters[1:10], each = n_groups))
  }

  p <-
    data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = bar_color) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    ylim(0, ylim_max) +
    ggtitle(plot_title) +
    geom_text(aes(label = sprintf("%1.0f", n), y = n + 3),
              position = position_dodge(0.9),
              vjust = 0,
              size = count_size) +
    theme(plot.title = element_text(hjust = 0.5))

  if (animate) {
    p <-
      p +
      transition_states(
        frame,
        transition_length = 10,
        state_length = 1,
        wrap = FALSE
      ) +
      ease_aes('linear')
    animate(p, fps=8, renderer = gifski_renderer(loop = FALSE))
  }

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @export
#' @rdname rfm_plot_order_dist
#' @usage NULL
#'
rfm_order_dist <- function(rfm_table, bar_color = 'blue',
                           xaxis_title = 'Orders', yaxis_title = 'Customers',
                           plot_title = 'Customers by Orders',
                           plot_title_justify = 0.5, print_plot = TRUE) {
  .Deprecated("rfm_plot_order_dist()")
  rfm_plot_order_dist(rfm_table, bar_color = 'blue',
                           xaxis_title = 'Orders', yaxis_title = 'Customers',
                           plot_title = 'Customers by Orders',
                           plot_title_justify = 0.5, print_plot = TRUE)
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

rfm_plot_combine <- function(rfm_table, x = "amount", y = "recency_days",
                             xaxis_title = "Monetary", yaxis_title = "Recency",
                             plot_title = "Recency vs Monetary", legend_title = "Segment") {

  plot <-
    rfm_table %>%
    ggplot() +
    geom_point(aes(x = .data[[x]], y = .data[[y]], color = factor(segment))) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    ggtitle(plot_title) +
    labs(color = legend_title)

  return(plot)
}


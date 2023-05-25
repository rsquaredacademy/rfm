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
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map
#' rfm_heatmap(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # heat map
#' rfm_heatmap(rfm_customer)
#'
#' @export
#'
rfm_heatmap <- function(data, plot_title = "RFM Heat Map",
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
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # histogram
#' rfm_histograms(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # histogram
#' rfm_histograms(rfm_customer)
#'
#' @export
#'
rfm_histograms <- function(rfm_table, hist_bins = 9, hist_color = 'blue',
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
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # bar chart
#' rfm_bar_chart(rfm_order)
#'
#' @export
#'
rfm_bar_chart <- function(rfm_table, bar_color = 'blue',
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


#' Customers by orders
#'
#' Visualize the distribution of customers across orders.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param bar_color Color of the bars.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param plot_title Title of the plot.
#' @param plot_title_justify Horizontal justification of the plot title;
#'   0 for left justified and 1 for right justified.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Bar chart.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # order distribution
#' rfm_order_dist(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # order distribution
#' rfm_order_dist(rfm_customer)
#'
#' @export
#'
rfm_order_dist <- function(rfm_table, bar_color = 'blue',
                           xaxis_title = 'Orders', yaxis_title = 'Customers',
                           plot_title = 'Customers by Orders',
                           plot_title_justify = 0.5, print_plot = TRUE) {

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

  p <-
    data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = bar_color) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    ylim(0, ylim_max) +
    ggtitle(plot_title) +
    geom_text(aes(label = n, y = n + 3), position = position_dodge(0.9), vjust = 0) +
    theme(plot.title = element_text(hjust = 0.5))

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

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
#' @examples
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' # segment intervals
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' # monetary value vs recency
#' rfm_rm_plot(segments)
#'
#' # frequency vs monetary value
#' rfm_fm_plot(segments)
#'
#' # frequency vs recency
#' rfm_rf_plot(segments)
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


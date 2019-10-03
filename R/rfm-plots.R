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
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map
#' rfm_heatmap(rfm_order)
#'
#' # using customer data
#' analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
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
    magrittr::extract2("monetary") %>%
    max() %>%
    ceiling(.)

  llm <-
    mapdata %>%
    magrittr::extract2("monetary") %>%
    min() %>%
    floor(.)

  bins <-
    mapdata %>%
    magrittr::use_series(frequency_score) %>%
    max()

  guide_breaks <-
    seq(llm, ulm, length.out = bins) %>%
    round()

  p <-
    ggplot2::ggplot(data = mapdata) +
    ggplot2::geom_tile(ggplot2::aes(x = frequency_score, y = recency_score, fill = monetary)) +
    ggplot2::scale_fill_gradientn(limits = c(llm, ulm),
                         colours = RColorBrewer::brewer.pal(n = brewer_n, name = brewer_name),
                         name = legend_title) +
    ggplot2::ggtitle(plot_title) + ggplot2::xlab(xaxis_title) + ggplot2::ylab(yaxis_title) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = plot_title_justify))

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
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # histogram
#' rfm_histograms(rfm_order)
#'
#' # using customer data
#' analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
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
    ggplot2::ggplot(ggplot2::aes(score)) +
    ggplot2::geom_histogram(bins = hist_bins, fill = hist_color) +
    ggplot2::ylab(yaxis_title) + ggplot2::ggtitle(plot_title) + ggplot2::xlab(xaxis_title) +
    ggplot2::facet_grid(. ~ rfm, scales = "free_x",
      labeller = ggplot2::labeller(
        rfm = c(amount = hist_m_label, recency_days = hist_r_label,
                transaction_count = hist_f_label))) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = plot_title_justify))

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
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
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
    ggplot2::ggplot() +
    ggplot2::geom_bar(ggplot2::aes(x = monetary_score), fill = bar_color) +
    ggplot2::facet_grid(recency_score ~ frequency_score) +
    ggplot2::scale_y_continuous(sec.axis = ggplot2::sec_axis(~ ., name = sec_yaxis_title)) +
    ggplot2::xlab(xaxis_title) + ggplot2::ylab(" ") + ggplot2::ggtitle(sec_xaxis_title) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        face = "plain", size = 11, hjust = 0.5
      ),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank()
    )

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
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # order distribution
#' rfm_order_dist(rfm_order)
#'
#' # using customer data
#' analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
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
    magrittr::use_series(rfm) %>%
    dplyr::count(transaction_count)

  ylim_max <-
    data %>%
    dplyr::pull(n) %>%
    max() %>%
    magrittr::multiply_by(1.1) %>%
    ceiling(.)

  p <-
    data %>%
    ggplot2::ggplot(ggplot2::aes(x = transaction_count, y = n)) +
    ggplot2::geom_bar(stat = "identity", fill = bar_color) +
    ggplot2::xlab(xaxis_title) + ggplot2::ylab(yaxis_title) + ggplot2::ylim(0, ylim_max) +
    ggplot2::ggtitle(plot_title) +
    ggplot2::geom_text(
      ggplot2::aes(label = n, y = n + 3), position = ggplot2::position_dodge(0.9), vjust = 0
    ) +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))

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
#' @param rfm_table An object of class \code{rfm_table}.
#' @param point_color Color of the scatter points.
#' @param xaxis_title X axis title.
#' @param yaxis_title Y axis title.
#' @param plot_title Title of the plot.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @return Scatter plot.
#'
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # monetary value vs recency
#' rfm_rm_plot(rfm_result)
#'
#' # frequency vs monetary value
#' rfm_fm_plot(rfm_result)
#'
#' # frequency vs recency
#' rfm_rf_plot(rfm_result)
#'
#' @export
#'
rfm_rm_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Monetary', yaxis_title = 'Recency',
                        plot_title = 'Recency vs Monetary',
                        print_plot = TRUE) {

  p <-
    rfm_table %>%
    magrittr::use_series(rfm) %>%
    ggplot2::ggplot() +
    ggplot2::geom_point(ggplot2::aes(x = amount, y = recency_days), color = point_color) +
    ggplot2::xlab(xaxis_title) + ggplot2::ylab(yaxis_title) + ggplot2::ggtitle(plot_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_fm_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Monetary', yaxis_title = 'Frequency',
                        plot_title = 'Frequency vs Monetary',
                        print_plot = TRUE) {

  p <-
    rfm_table %>%
    magrittr::use_series(rfm) %>%
    ggplot2::ggplot() +
    ggplot2::geom_point(ggplot2::aes(x = amount, y = transaction_count), color = point_color) +
    ggplot2::xlab(xaxis_title) + ggplot2::ylab(yaxis_title) + ggplot2::ggtitle(plot_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_rf_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Frequency', yaxis_title = 'Recency',
                        plot_title = 'Recency vs Frequency',
                        print_plot = TRUE) {

  p <-
    rfm_table %>%
    magrittr::use_series(rfm) %>%
    ggplot2::ggplot() +
    ggplot2::geom_point(ggplot2::aes(x = transaction_count, y = recency_days), color = point_color) +
    ggplot2::xlab(xaxis_title) + ggplot2::ylab(yaxis_title) + ggplot2::ggtitle(plot_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

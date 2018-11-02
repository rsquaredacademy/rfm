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
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
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

  rfm_score_table <-
    data %>%
    magrittr::use_series(rfm) %>%
    dplyr::mutate(segment = 1)

  n_segments <- length(segment_names)

  for (i in seq_len(n_segments)) {
    rfm_score_table$segment[(
      (rfm_score_table$recency_score %>% dplyr::between(recency_lower[i], recency_upper[i])) &
        (rfm_score_table$frequency_score %>% dplyr::between(frequency_lower[i], frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% dplyr::between(monetary_lower[i], monetary_upper[i])))] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"
  rfm_score_table$segment[rfm_score_table$segment == 1]   <- "Others"

  rfm_score_table %>%
    dplyr::select(customer_id, segment, rfm_score, transaction_count, recency_days,
           amount, date_most_recent, recency_score, frequency_score,
           monetary_score)


}

#' Segmentation plots
#'
#' Segment wise median recency, frequency & monetary value plot.
#'
#' @param rfm_segment_table Output from \code{rfm_segment}.
#'
#' @examples
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' rfm_plot_median_recency(segments)
#' rfm_plot_median_frequency(segments)
#' rfm_plot_median_monetary(segments)
#'
#' @export
#'
rfm_plot_median_recency <- function(rfm_segment_table) {

  segment <- NULL
  avg_recency <- NULL

  data <-
    rfm_segment_table %>%
    dplyr::group_by(segment) %>%
    dplyr::select(segment, recency_days) %>%
    dplyr::summarise(avg_recency = stats::median(recency_days)) %>%
    # dplyr::rename(segment = segment, avg_recency = `median(recency_days)`) %>%
    dplyr::arrange(avg_recency)

  n_fill <- nrow(data)

  p <-
    ggplot2::ggplot(data, ggplot2::aes(segment, avg_recency)) +
    ggplot2::geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
    ggplot2::xlab("Segment") + ggplot2::ylab("Median Recency") +
    ggplot2::ggtitle("Median Recency by Segment") +
    ggplot2::coord_flip() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5)
    )

  print(p)

}

#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_frequency <- function(rfm_segment_table) {

  segment <- NULL
  avg_frequency <- NULL

  data <-
    rfm_segment_table %>%
    dplyr::group_by(segment) %>%
    dplyr::select(segment, transaction_count) %>%
    dplyr::summarise(avg_frequency = stats::median(transaction_count)) %>%
    # dplyr::rename(segment = segment, avg_frequency = `median(transaction_count)`) %>%
    dplyr::arrange(avg_frequency)

  n_fill <- nrow(data)

  p <-
    ggplot2::ggplot(data, ggplot2::aes(segment, avg_frequency)) +
    ggplot2::geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
    ggplot2::xlab("Segment") + ggplot2::ylab("Median Frequency") +
    ggplot2::ggtitle("Median Frequency by Segment") +
    ggplot2::coord_flip() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5)
    )

  print(p)

}


#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_monetary <- function(rfm_segment_table) {

  segment <- NULL
  avg_monetary <- NULL

  data <-
    rfm_segment_table %>%
    dplyr::group_by(segment) %>%
    dplyr::select(segment, amount) %>%
    dplyr::summarise(avg_monetary = stats::median(amount)) %>%
    # dplyr::rename(segment = segment, avg_monetary = `median(amount)`) %>%
    dplyr::arrange(avg_monetary)

  n_fill <- nrow(data)

  p <-
    ggplot2::ggplot(data, ggplot2::aes(segment, avg_monetary)) +
    ggplot2::geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
    ggplot2::xlab("Segment") + ggplot2::ylab("Median Monetary Value") +
    ggplot2::ggtitle("Median Monetary Value by Segment") +
    ggplot2::coord_flip() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5)
    )

  print(p)

}

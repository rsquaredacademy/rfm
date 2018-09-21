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

  rfm_score_table <-
    data %>%
    use_series(rfm) %>%
    mutate(segment = 1)

  n_segments <- length(segment_names)

  for (i in seq_len(n_segments)) {
    rfm_score_table$segment[(
      (rfm_score_table$recency_score %>% between(recency_lower[i], recency_upper[i])) &
        (rfm_score_table$frequency_score %>% between(frequency_lower[i], frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% between(monetary_lower[i], monetary_upper[i])))] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"

  rfm_score_table %>%
    select(customer_id, segment, rfm_score, transaction_count, recency_days,
           amount, date_most_recent, recency_score, frequency_score,
           monetary_score)


}

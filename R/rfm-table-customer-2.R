#' RFM table 2 (customer data)
#'
#' Recency, frequency, monetary and RFM score.
#'
#' @param data A \code{data.frame} or \code{tibble}.
#' @param customer_id Unique id of the customer.
#' @param n_transactions Number of transactions/orders.
#' @param latest_visit_date Date of the latest visit.
#' @param total_revenue Total revenue from the customer.
#' @param analysis_date Date of analysis.
#' @param recency_bins Number of bins for recency or custom threshold.
#' @param frequency_bins Number of bins for frequency or custom threshold.
#' @param monetary_bins Number of bins for monetary or custom threshold.
#' @param ... Other arguments.
#'
#' @return \code{rfm_table_order} returns a list with the following:
#'
#' \item{rfm}{RFM table.}
#' \item{analysis_date}{Date of analysis.}
#' \item{frequency_bins}{Number of bins used for frequency score.}
#' \item{recency_bins}{Number of bins used for recency score.}
#' \item{monetary_bins}{Number of bins used for monetary score.}
#' \item{threshold}{tibble with thresholds used for generating RFM scores.}
#'
#' @examples
#' analysis_date <- lubridate::as_date('2007-01-01')
#' rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders,
#' most_recent_visit, revenue, analysis_date)
#'
#' # access rfm table
#' result <- rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders,
#' most_recent_visit, revenue, analysis_date)
#' result$rfm
#'
#' # using custom threshold 
#' rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders,
#' most_recent_visit, revenue, analysis_date, recency_bins = c(115, 181, 297, 482), 
#' frequency_bins = c(4, 5, 6, 8), monetary_bins = c(256, 382, 506, 666))
#'
#' @export
#'
rfm_table_customer_2 <- function(data = NULL, customer_id = NULL, n_transactions = NULL,
                            latest_visit_date = NULL, total_revenue = NULL, analysis_date = NULL, recency_bins = 5,
                            frequency_bins = 5, monetary_bins = 5, ...) UseMethod("rfm_table_customer_2")

#' @export
#'
rfm_table_customer_2.default <- function(data = NULL, customer_id = NULL, n_transactions = NULL,
                                       latest_visit_date = NULL, total_revenue = NULL, analysis_date = NULL,
                                       recency_bins = 5, frequency_bins = 5, monetary_bins = 5, ...) {

  cust_id      <- rlang::enquo(customer_id)
  order_count  <- rlang::enquo(n_transactions)
  recent_visit <- rlang::enquo(latest_visit_date)
  revenues     <- rlang::enquo(total_revenue)

  result <-
    data %>%
    dplyr::mutate(
      recency_days = (analysis_date - !! recent_visit) / lubridate::ddays()
    ) %>%
    dplyr::select(!! cust_id, recency_days, !! order_count, !! revenues) %>%
    set_names(c("customer_id", "recency_days", "transaction_count", "amount"))

  result$recency_score   <- NA
  result$frequency_score <- NA
  result$monetary_score  <- NA

  if (length(recency_bins) == 1) {
    rscore <- rev(seq_len(recency_bins))
  } else {
    rscore <- rev(seq_len((length(recency_bins) + 1)))
  }

  if (length(recency_bins) == 1) {
    bins_recency <- bins(result, recency_days, recency_bins)
  } else {
    bins_recency <- recency_bins
  }
  lower_recency <- bins_lower(result, recency_days, bins_recency)
  upper_recency <- bins_upper(result, recency_days, bins_recency)

  rscore_len <- length(rscore)

  for (i in seq_len(rscore_len)) {
    result$recency_score[result$recency_days >= lower_recency[i] &
                           result$recency_days < upper_recency[i]] <- rscore[i]
  }

  if (length(frequency_bins) == 1) {
    fscore <- rev(seq_len(frequency_bins))
  } else {
    fscore <- rev(seq_len((length(frequency_bins) + 1)))
  }

  if (length(frequency_bins) == 1) {
    bins_frequency <- bins(result, transaction_count, frequency_bins)
  } else {
    bins_frequency <- frequency_bins
  }
  lower_frequency <- bins_lower(result, transaction_count, bins_frequency)
  upper_frequency <- bins_upper(result, transaction_count, bins_frequency)

  fscore_len <- length(fscore)

  for (i in seq_len(fscore_len)) {
    result$frequency_score[result$transaction_count >= lower_frequency[i] &
                             result$transaction_count < upper_frequency[i]] <- i
  }

  if (length(monetary_bins) == 1) {
    mscore <- rev(seq_len(monetary_bins))
  } else {
    mscore <- rev(seq_len((length(monetary_bins) + 1)))
  }

  if (length(monetary_bins) == 1) {
    bins_monetary <- bins(result, amount, monetary_bins)
  } else {
    bins_monetary <- monetary_bins
  }
  lower_monetary <- bins_lower(result, amount, bins_monetary)
  upper_monetary <- bins_upper(result, amount, bins_monetary)

  mscore_len <- length(mscore)

  for (i in seq_len(mscore_len)) {
    result$monetary_score[result$amount >= lower_monetary[i] &
                            result$amount < upper_monetary[i]] <- i
  }

  result %<>%
    dplyr::mutate(
      rfm_score = recency_score * 100 + frequency_score * 10 + monetary_score
    )

  result$transaction_count <- as.numeric(result$transaction_count)

  threshold <- tibble::tibble(recency_lower   = lower_recency,
                              recency_upper   = upper_recency,
                              frequency_lower = lower_frequency,
                              frequency_upper = upper_frequency,
                              monetary_lower  = lower_monetary,
                              monetary_upper  = upper_monetary)

  out <- list(
    rfm            = result,
    analysis_date  = analysis_date,
    frequency_bins = frequency_bins,
    recency_bins   = recency_bins,
    monetary_bins  = monetary_bins,
    threshold      = threshold
  )

  class(out) <- c("rfm_table_customer_2", "tibble", "data.frame")
  return(out)

}



#' @export
#'
print.rfm_table_customer_2 <- function(x, ...) {
  print(x$rfm)
}

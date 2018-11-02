#' RFM table (transaction data)
#'
#' Recency, frequency, monetary and RFM score.
#'
#' @param data A \code{data.frame} or \code{tibble}.
#' @param customer_id Unique id of the customer.
#' @param order_date Date of the transaction.
#' @param revenue Revenue from the customer.
#' @param analysis_date Date of analysis.
#' @param recency_bins Number of bins for recency.
#' @param frequency_bins Number of bins for frequency.
#' @param monetary_bins Number of bins for monetary.
#' @param ... Other arguments.
#'
#' @return \code{rfm_table_order} returns a tibble with the following columns:
#'
#' \item{customer_id}{Unique id of the customer.}
#' \item{date_most_recent}{Date of the most recent transaction.}
#' \item{recency_days}{Number of days since the most recent transaction.}
#' \item{transaction_count}{Total number of transactions of the customer.}
#' \item{amount}{Revenue from the customer.}
#' \item{recency_score}{Recency score of the customer.}
#' \item{frequency_score}{Frequency score of the customer.}
#' \item{monetary_score}{Monetary score of the customer.}
#' \item{rfm_score}{RFM score of the customer.}
#'
#' @examples
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#'
#' # access rfm table
#' result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#' result$rfm
#'
#' @export
#'
rfm_table_order <- function(data = NULL, customer_id = NULL, order_date = NULL,
                      revenue = NULL, analysis_date = NULL, recency_bins = 5,
                      frequency_bins = 5, monetary_bins = 5, ...) UseMethod("rfm_table_order")

#' @export
#'
rfm_table_order.default <- function(data = NULL, customer_id = NULL, order_date = NULL,
                              revenue = NULL, analysis_date = NULL, recency_bins = 5,
                              frequency_bins = 5, monetary_bins = 5, ...) {

  cust_id  <- rlang::enquo(customer_id)
  odate    <- rlang::enquo(order_date)
  revenues <- rlang::enquo(revenue)

  result <-
    data %>%
    dplyr::select(!! cust_id, !! odate, !! revenues) %>%
    dplyr::group_by(!! cust_id) %>%
    dplyr::summarise(
      date_most_recent = max(!! odate), amount = sum(!! revenues),
      transaction_count = dplyr::n()
    ) %>%
    dplyr::mutate(
      recency_days = (analysis_date - date_most_recent) / lubridate::ddays()
    ) %>%
    dplyr::select(
      !! cust_id, date_most_recent, recency_days, transaction_count,
      amount
    ) %>%
    magrittr::set_names(c("customer_id", "date_most_recent", "recency_days", "transaction_count", "amount"))

  result$recency_score   <- NA
  result$frequency_score <- NA
  result$monetary_score  <- NA

  rscore <-
    recency_bins %>%
    seq_len(.) %>%
    rev()

  if (length(recency_bins) == 1) {
    bins_recency <- bins(result, recency_days, recency_bins)
  } else {
    bins_recency <- recency_bins
  }
  lower_recency <- bins_lower(result, recency_days, bins_recency)
  upper_recency <- bins_upper(result, recency_days, bins_recency)

  for (i in seq_len(recency_bins)) {
    result$recency_score[result$recency_days >= lower_recency[i] &
      result$recency_days < upper_recency[i]] <- rscore[i]
  }

  fscore <-
    frequency_bins %>%
    seq_len(.) %>%
    rev()

  if (length(frequency_bins) == 1) {
    bins_frequency <- bins(result, transaction_count, frequency_bins)
  } else {
    bins_frequency <- frequency_bins
  }
  lower_frequency <- bins_lower(result, transaction_count, bins_frequency)
  upper_frequency <- bins_upper(result, transaction_count, bins_frequency)

  for (i in seq_len(frequency_bins)) {
    result$frequency_score[result$transaction_count >= lower_frequency[i] &
      result$transaction_count < upper_frequency[i]] <- i
  }

  mscore <-
    monetary_bins %>%
    seq_len(.) %>%
    rev()

  if (length(monetary_bins) == 1) {
    bins_monetary <- bins(result, amount, monetary_bins)
  } else {
    bins_monetary <- monetary_bins
  }
  lower_monetary <- bins_lower(result, amount, bins_monetary)
  upper_monetary <- bins_upper(result, amount, bins_monetary)

  for (i in seq_len(monetary_bins)) {
    result$monetary_score[result$amount >= lower_monetary[i] &
      result$amount < upper_monetary[i]] <- i
  }

  result %<>%
    dplyr::mutate(
      rfm_score = recency_score * 100 + frequency_score * 10 + monetary_score
    ) %>%
    dplyr::select(
      customer_id, date_most_recent, recency_days, transaction_count, amount,
      recency_score, frequency_score, monetary_score, rfm_score
    )

  result$transaction_count <- as.numeric(result$transaction_count)

  out <- list(
    rfm            = result,
    analysis_date  = analysis_date,
    frequency_bins = frequency_bins,
    recency_bins   = recency_bins,
    monetary_bins  = monetary_bins
  )

  class(out) <- c("rfm_table_order", "tibble", "data.frame")
  return(out)

}



#' @export
#'
print.rfm_table_order <- function(x, ...) {
  print(x$rfm)
}





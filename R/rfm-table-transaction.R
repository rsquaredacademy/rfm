#' RFM table (transaction data)
#'
#' Recency, frequency, monetary and RFM score.
#'
#' @param data A \code{data.frame} or \code{tibble}.
#' @param customer_id Unique id of the customer.
#' @param order_date Date of the transaction.
#' @param revenue Revenue from the customer.
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
#' \item{threshold}{thresholds used for generating RFM scores.}
#'
#' @examples
#' analysis_date <- as.Date('2006-12-31')
#' rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#'
#' # access rfm table
#' result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#' result$rfm
#'
#' # using custom threshold
#' rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date,
#' recency_bins = c(115, 181, 297, 482), frequency_bins = c(4, 5, 6, 8),
#' monetary_bins = c(256, 382, 506, 666))
#'
#' @export
#'
rfm_table_order <- function(data = NULL, customer_id = NULL, order_date = NULL,
                              revenue = NULL, analysis_date = NULL, recency_bins = 5,
                              frequency_bins = 5, monetary_bins = 5, ...) {

  cust_id <- deparse(substitute(customer_id))
  odate   <- deparse(substitute(order_date))
  reven   <- deparse(substitute(revenue))                                  

  result <- rfm_prep_table_data(data, cust_id, odate, reven, analysis_date)
  out    <- rfm_prep_bins(result, recency_bins, frequency_bins, monetary_bins, analysis_date)

  return(out)

}

rfm_prep_table_data <- function(data, customer_id, order_date, revenue, analysis_date) {

  result <- 
    data %>% 
    data.table() %>% 
    .[, .(date_most_recent = max(order_date),
          amount = sum(revenue),
          transaction_count = .N), 
      by = customer_id] %>% 
    .[, ':='(recency_days = as.numeric(analysis_date - date_most_recent, units = "days"))] %>% 
    .[, .(customer_id, recency_days, transaction_count, amount)] %>% 
    setDF()

  return(result)
}

rfm_prep_bins <- function(result, recency_bins, frequency_bins, monetary_bins, analysis_date) {

  result$recency_score   <- NA
  result$frequency_score <- NA
  result$monetary_score  <- NA

  if (length(recency_bins) == 1) {
    rscore <- rev(seq_len(recency_bins))
    bins_recency <- bins(result, recency_days, recency_bins)
  } else {
    rscore <- rev(seq_len((length(recency_bins) + 1)))
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
    bins_frequency <- bins(result, transaction_count, frequency_bins)
  } else {
    fscore <- rev(seq_len((length(frequency_bins) + 1)))
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
    bins_monetary <- bins(result, amount, monetary_bins)
  } else {
    mscore <- rev(seq_len((length(monetary_bins) + 1)))
    bins_monetary <- monetary_bins
  }


  lower_monetary <- bins_lower(result, amount, bins_monetary)
  upper_monetary <- bins_upper(result, amount, bins_monetary)

  mscore_len <- length(mscore)

  for (i in seq_len(mscore_len)) {
    result$monetary_score[result$amount >= lower_monetary[i] &
      result$amount < upper_monetary[i]] <- i
  }

  result$rfm_score <- result$recency_score * 100 + result$frequency_score * 10 + result$monetary_score

  result$transaction_count <- as.numeric(result$transaction_count)

  threshold <- data.frame(recency_lower   = lower_recency,
                          recency_upper   = upper_recency,
                          frequency_lower = lower_frequency,
                          frequency_upper = upper_frequency,
                          monetary_lower  = lower_monetary,
                          monetary_upper  = upper_monetary)

  list(rfm = result, analysis_date = analysis_date, frequency_bins = frequency_bins,
       recency_bins = recency_bins, monetary_bins = monetary_bins, threshold = threshold)

}

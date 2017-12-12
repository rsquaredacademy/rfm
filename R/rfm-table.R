#' @importFrom dplyr pull select group_by summarise mutate n
#' @importFrom lubridate ddays is.POSIXct
#' @importFrom magrittr extract2
#' @importFrom rlang quo enquo
#' @title RFM Table
#' @description Table with recency, frequency, monetary and RFM score
#' @param data a data.frame or tibble
#' @param customer_id unique id of the customer
#' @param order_date date of transaction
#' @param revenue revenue from the customer
#' @param analysis_date data of analysis
#' @param recency_bins number of bins for recency
#' @param frequency_bins number of bins for frequency
#' @param monetary_bins number of bins for monetary
#' @param ... other arguments
#' @param x an object of class \code{rfm_table}
#' @return \code{rfm_table} returns a tibble with the following columns:
#'
#' \item{customer_id}{unique id of the customer}
#' \item{date_most_recent}{date of the most recent transaction}
#' \item{recency_days}{number of days since the most recent transaction}
#' \item{transaction_count}{total number of transactions of the customer}
#' \item{revenue}{revenue from the customer}
#'
#' @examples
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#' @export
#'
rfm_table <- function(data = NULL, customer_id = NULL, order_date = NULL,
                      revenue = NULL, analysis_date = NULL, recency_bins = 5,
                      frequency_bins = 5, monetary_bins = 5, ...) UseMethod("rfm_table")

#' @export
#'
rfm_table.default <- function(data = NULL, customer_id = NULL, order_date = NULL,
                              revenue = NULL, analysis_date = NULL, recency_bins = 5,
                              frequency_bins = 5, monetary_bins = 5, ...) {
  cust_id <- enquo(customer_id)
  odate <- enquo(order_date)
  revenues <- enquo(revenue)

  result <- data %>%
    select(!! cust_id, !! odate, !! revenues) %>%
    group_by(!! cust_id) %>%
    summarise(
      date_most_recent = max(!! odate), amount = sum(!! revenues),
      transaction_count = n()
    ) %>%
    mutate(
      recency_days = (analysis_date - date_most_recent) / ddays()
    ) %>%
    select(
      !! cust_id, date_most_recent, recency_days, transaction_count,
      amount
    )

  result$recency_score <- NA
  result$frequency_score <- NA
  result$monetary_score <- NA

  rscore <- recency_bins %>%
    seq_len() %>%
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

  fscore <- frequency_bins %>%
    seq_len() %>%
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

  mscore <- monetary_bins %>%
    seq_len() %>%
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
    mutate(
      rfm_score = recency_score * 100 + frequency_score * 10 + monetary_score
    ) %>%
    select(
      !! cust_id, date_most_recent, recency_days, transaction_count, amount,
      recency_score, frequency_score, monetary_score, rfm_score
    )

  result$transaction_count <- as.numeric(result$transaction_count)

  out <- list(
    rfm = result, analysis_date = analysis_date,
    frequency_bins = frequency_bins, recency_bins = recency_bins,
    monetary_bins = monetary_bins
  )
  class(out) <- c("rfm_table", "tibble", "data.frame")
  return(out)
}


#' @rdname rfm_table
#' @export
#'
print.rfm_table <- function(x, ...) {
  print(x$rfm)
}

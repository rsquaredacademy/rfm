#' RFM table (transaction data)
#'
#' Recency, frequency, monetary and RFM score.
#'
#' @param data A \code{data.frame} or \code{tibble}.
#'   Extra columns are retained only when constant within each customer.
#'   Columns that vary within a customer are dropped with a message.
#' @param customer_id Unique id of the customer.
#' @param order_date Date of the transaction.
#' @param revenue Revenue from the customer.
#' @param analysis_date Date of analysis.
#' @param recency_bins Number of bins for recency or custom threshold.
#' @param frequency_bins Number of bins for frequency or custom threshold.
#' @param monetary_bins Number of bins for monetary or custom threshold.
#' @param ... Other arguments.
#'
#' @details Automatic bins use unshifted sample quantiles. Intervals are
#'   right-closed: `q[i - 1] < x <= q[i]`, with the minimum included in the
#'   lowest interval and the maximum included in the highest interval. Values
#'   tied at a boundary stay in the lower interval; repeated boundaries can
#'   leave intervals empty. Frequency and monetary scores increase with the
#'   interval number; recency scores decrease. Custom thresholds remain
#'   lower-inclusive: a value equal to a threshold enters the next interval.
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
#' analysis_date <- as.Date("2006-12-31")
#' rfm_table_order(
#'   rfm_data_orders, customer_id, order_date, revenue,
#'   analysis_date
#' )
#'
#' # access rfm table
#' result <- rfm_table_order(
#'   rfm_data_orders, customer_id, order_date,
#'   revenue, analysis_date
#' )
#' result$rfm
#'
#' # using custom threshold
#' rfm_table_order(rfm_data_orders, customer_id, order_date, revenue,
#'   analysis_date,
#'   recency_bins = c(115, 181, 297, 482), frequency_bins = c(4, 5, 6, 8),
#'   monetary_bins = c(256, 382, 506, 666)
#' )
#'
#' @export
#'
rfm_table_order <- function(data = NULL, customer_id = NULL, order_date = NULL,
                            revenue = NULL, analysis_date = NULL,
                            recency_bins = 5, frequency_bins = 5,
                            monetary_bins = 5, ...) UseMethod("rfm_table_order")

#' @importFrom dplyr distinct ungroup
#' @export
#'
rfm_table_order.default <- function(data = NULL, customer_id = NULL,
                                    order_date = NULL, revenue = NULL,
                                    analysis_date = NULL, recency_bins = 5,
                                    frequency_bins = 5, monetary_bins = 5, ...) {
  data <- ungroup(data)
  result <- rfm_prep_table_data(
    data, {{ customer_id }}, {{ order_date }},
    {{ revenue }}, analysis_date
  )

  other_cols <-
    data %>%
    select(!c({{ order_date }}, {{ revenue }})) %>%
    rename(customer_id = {{ customer_id }}) %>%
    rfm_customer_metadata()

  out <- rfm_prep_bins(
    result, recency_bins, frequency_bins, monetary_bins,
    analysis_date, other_cols
  )

  class(out) <- c("rfm_table_order", "tibble", "data.frame")
  return(out)
}

#' @export
#'
print.rfm_table_order <- function(x, ...) {
  print(x$rfm)
}


#' @importFrom dplyr select group_by summarise n mutate
#' @importFrom magrittr %>% %<>% set_names
rfm_prep_table_data <- function(data, customer_id, order_date, revenue,
                                analysis_date) {
  data %>%
    select({{ customer_id }}, {{ order_date }}, {{ revenue }}) %>%
    group_by({{ customer_id }}) %>%
    summarise(
      date_most_recent = max({{ order_date }}),
      amount = sum({{ revenue }}),
      transaction_count = n()
    ) %>%
    mutate(recency_days = as.numeric(analysis_date - date_most_recent,
      units = "days"
    )) %>%
    select(
      {{ customer_id }}, date_most_recent, recency_days, transaction_count,
      amount
    ) %>%
    set_names(c(
      "customer_id", "date_most_recent", "recency_days",
      "transaction_count", "amount"
    ))
}

#' @importFrom rlang int
#' @importFrom dplyr left_join join_by
rfm_prep_bins <- function(result, recency_bins, frequency_bins, monetary_bins,
                          analysis_date, data) {
  if (anyDuplicated(result$customer_id) || anyDuplicated(data$customer_id)) {
    stop("Duplicated customer IDs: customer-level input must have one row per customer.",
         call. = FALSE)
  }
  result$recency_score <- NA
  result$frequency_score <- NA
  result$monetary_score <- NA

  if (length(recency_bins) == 1) {
    rscore <- rev(seq_len(recency_bins))
    bins_recency <- bins(result, "recency_days", recency_bins)
  } else {
    rscore <- rev(seq_len((length(recency_bins) + 1)))
    bins_recency <- recency_bins
  }

  lower_recency <- bins_lower(result, "recency_days", bins_recency)
  upper_recency <- bins_upper(result, "recency_days", bins_recency,
                              right = length(recency_bins) == 1)

  rscore_len <- length(rscore)

  result$recency_score <- rscore_len + 1L - rfm_bin_score(
    result$recency_days, bins_recency, right = length(recency_bins) == 1
  )


  if (length(frequency_bins) == 1) {
    bins_frequency <- bins(result, "transaction_count", frequency_bins)
  } else {
    bins_frequency <- frequency_bins
  }

  lower_frequency <- bins_lower(result, "transaction_count", bins_frequency)
  upper_frequency <- bins_upper(result, "transaction_count", bins_frequency,
                                right = length(frequency_bins) == 1)

  result$frequency_score <- rfm_bin_score(
    result$transaction_count, bins_frequency, right = length(frequency_bins) == 1
  )

  if (length(monetary_bins) == 1) {
    bins_monetary <- bins(result, "amount", monetary_bins)
  } else {
    bins_monetary <- monetary_bins
  }


  lower_monetary <- bins_lower(result, "amount", bins_monetary)
  upper_monetary <- bins_upper(result, "amount", bins_monetary,
                               right = length(monetary_bins) == 1)

  result$monetary_score <- rfm_bin_score(
    result$amount, bins_monetary, right = length(monetary_bins) == 1
  )

  result %<>%
    mutate(
      rfm_score = recency_score * 100 + frequency_score * 10 + monetary_score
    ) %>%
    select(
      customer_id, recency_days, transaction_count, amount,
      recency_score, frequency_score, monetary_score, rfm_score
    )

  result$transaction_count <- int(result$transaction_count)

  duplicate_cols <- intersect(
    setdiff(names(result), "customer_id"),
    names(data)
  )
  if (length(duplicate_cols) > 0) {
    data <- data[, setdiff(names(data), duplicate_cols), drop = FALSE]
  }

  result <- left_join(result, data, by = join_by(customer_id))

  threshold_n <- max(
    length(lower_recency), length(lower_frequency), length(lower_monetary)
  )
  pad_threshold <- function(x) {
    c(x, rep(NA, threshold_n - length(x)))
  }

  threshold <- data.frame(
    recency_lower = pad_threshold(lower_recency),
    recency_upper = pad_threshold(upper_recency),
    frequency_lower = pad_threshold(lower_frequency),
    frequency_upper = pad_threshold(upper_frequency),
    monetary_lower = pad_threshold(lower_monetary),
    monetary_upper = pad_threshold(upper_monetary)
  )

  list(
    rfm = result,
    analysis_date = analysis_date,
    frequency_bins = frequency_bins,
    recency_bins = recency_bins,
    monetary_bins = monetary_bins,
    threshold = threshold
  )
}

rfm_bin_score <- function(x, thresholds, right) {
  findInterval(x, thresholds, left.open = right) + 1L
}

#' @importFrom dplyr across all_of n_distinct
rfm_customer_metadata <- function(data) {
  counts <- data %>%
    group_by(customer_id) %>%
    summarise(across(everything(), n_distinct), .groups = "drop")
  varying <- names(counts)[vapply(counts, function(x) any(x > 1), logical(1))]
  varying <- setdiff(varying, "customer_id")
  if (length(varying) > 0) {
    message("Dropping columns that vary within a customer: ",
            paste(varying, collapse = ", "))
  }
  data %>%
    select(-all_of(varying)) %>%
    distinct()
}

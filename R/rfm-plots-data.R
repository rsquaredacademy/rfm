#' Heatmap data
#'
#' Data for generating heatmap.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map data
#' rfm_heatmap_data(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # heat map data
#' rfm_heatmap_data(rfm_customer)
#'
#' @export
#'
rfm_heatmap_data <- function(rfm_table) {

  result <-
    rfm_table %>%
    magrittr::use_series(rfm) %>%
    dplyr::group_by(frequency_score, recency_score) %>%
    dplyr::select(frequency_score, recency_score, amount) %>%
    dplyr::summarise(monetary = mean(amount))

  l_frequency      <- check_levels(result, frequency_score)
  l_recency        <- check_levels(result, recency_score)
  levels_frequency <- check_levels(result, frequency_score) %>% length()
  levels_recency   <- check_levels(result, recency_score) %>% length()
  f_frequency      <- magrittr::use_series(rfm_table, frequency_bins)
  r_recency        <- magrittr::use_series(rfm_table, recency_bins)

  if (levels_frequency != f_frequency) {
    result %<>%
      modify_rfm(., f_frequency, l_frequency)
  }

  if (levels_recency != r_recency) {
    result %<>%
      modify_rfm(., r_recency, l_recency)
  }

  return(result)

}

#' Histogram data
#'
#' Data for generating histograms.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # histogram data
#' rfm_hist_data(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # histogram data
#' rfm_hist_data(rfm_customer)
#'
#' @export
#'
rfm_hist_data <- function(rfm_table) {

  cnames <- c("recency_days", "transaction_count", "amount")
  out    <- rfm_table$rfm[, cnames]
  rfm    <- rep(cnames, each = nrow(out))
  score  <- c(out$recency_days, out$transaction_count, out$amount)
  data.frame(rfm, score)
  
}

#' Bar chart data
#'
#' Data for generating bar charts.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- as.Date('2006-12-31')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # bar chart data
#' rfm_barchart_data(rfm_order)
#'
#' # using customer data
#' analysis_date <- as.Date('2007-01-01')
#' rfm_customer <- rfm_table_customer(rfm_data_customer, customer_id,
#' number_of_orders, recency_days, revenue, analysis_date)
#'
#' # bar chart data
#' rfm_barchart_data(rfm_customer)
#'
#' @export
#'
rfm_barchart_data <- function(rfm_table) {

  rlevels <-
    rfm_table %>%
    magrittr::use_series(recency_bins) %>%
    seq_len(.) %>%
    rev()

  data <- magrittr::use_series(rfm_table, rfm)
  data$recency_score <- factor(data$recency_score, levels = rlevels)

  return(data)

}

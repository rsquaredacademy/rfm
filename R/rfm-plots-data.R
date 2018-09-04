#' Heatmap data
#'
#' Data for generating heatmap.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#'
#' @examples
#' # using transaction data
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # heat map data
#' rfm_heatmap_data(rfm_order)
#'
#' # using customer data
#' analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
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
    use_series(rfm) %>%
    group_by(frequency_score, recency_score) %>%
    select(frequency_score, recency_score, amount) %>%
    summarise(monetary = mean(amount))

  l_frequency      <- check_levels(result, frequency_score)
  l_recency        <- check_levels(result, recency_score)
  levels_frequency <- check_levels(result, frequency_score) %>% length()
  levels_recency   <- check_levels(result, recency_score) %>% length()

  f_frequency <- use_series(rfm_table, frequency_bins)
  r_recency   <- use_series(rfm_table, recency_bins)

  if (!are_equal(levels_frequency, f_frequency)) {
    result %<>%
      modify_rfm(., f_frequency, l_frequency)
  }

  if (!are_equal(levels_recency, r_recency)) {
    result %<>%
      modify_rfm(., r_recency, l_recency)
  }

  return(result)

}

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
    use_series(rfm) %>%
    data.table() %>%
    .[, .(frequency_score, recency_score, amount)] %>%
    .[, .(monetary = mean(amount)),
      keyby = .(frequency_score, recency_score)] %>%
    setDF()

  l_frequency      <- check_levels(result, frequency_score)
  l_recency        <- check_levels(result, recency_score)
  levels_frequency <- check_levels(result, frequency_score) %>% length()
  levels_recency   <- check_levels(result, recency_score) %>% length()
  f_frequency      <- use_series(rfm_table, frequency_bins)
  r_recency        <- use_series(rfm_table, recency_bins)

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
    use_series(recency_bins) %>%
    seq_len(.) %>%
    rev()

  data <- use_series(rfm_table, rfm)
  data$recency_score <- factor(data$recency_score, levels = rlevels)

  return(data)

}

rfm_order_dist_data <- function(rfm_table) {
  rfm_table %>%
    use_series(rfm) %>%
    data.table() %>%
    .[, .(n = .N), by = transaction_count] %>%
    setnames(old = "transaction_count", new = "segment") %>%
    setDF()
}

rfm_order_dist_ylim <- function(data) {
  data %>%
    use_series(n) %>%
    max() %>%
    multiply_by(1.1) %>%
    ceiling(.)
}

rfm_prep_revenue_dist <- function(x) {

  x$customer_share <- x$customers / sum(x$customers)
  x$revenue_share <- x$revenue / sum(x$revenue)
  data <- x[c("segment", "customer_share", "revenue_share")]

  n_row    <- nrow(data)
  segment  <- rep(data$segment, each = 2)
  category <- rep(c("customer_share", "revenue_share"), times = n_row)

  share <- c()
  for (i in seq_len(n_row)) {
    y <- as.numeric(data[i, c(2, 3)])
    share <- c(share, y)
  }

  result <- data.frame(segment, category, share)
  result$category <- factor(result$category,
                            levels = c("revenue_share", "customer_share"))
  return(result)
}

rfm_prep_median <- function(rfm_segment_table, metric) {

  met <- deparse(substitute(metric))

  result <-
    rfm_segment_table %>%
    data.table() %>%
    .[, .(segment, met = get(met))] %>%
    .[, .(mem = median(met)), by = segment] %>%
    .[order(mem)] %>%
    setnames(old = "mem", new = met) %>%
    setDF()

  return(result)

}

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
#' @importFrom magrittr use_series
#' @importFrom dplyr group_by summarise
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

  f_frequency      <- use_series(rfm_table, frequency_bins)
  r_recency        <- use_series(rfm_table, recency_bins)

  n_frequency <- if (length(f_frequency) == 1) {
    f_frequency
  } else {
    length(f_frequency) + 1
  }
  n_recency <- if (length(r_recency) == 1) {
    r_recency
  } else {
    length(r_recency) + 1
  }

  grid <- expand.grid(
    recency_score   = seq_len(n_recency),
    frequency_score = seq_len(n_frequency)
  )
  grid <- grid[c("frequency_score", "recency_score")]

  result <-
    grid %>%
    left_join(as.data.frame(result), by = c("frequency_score", "recency_score"))

  result$monetary[is.na(result$monetary)] <- 0
  result <- group_by(result, frequency_score)

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

  recency_bins <- use_series(rfm_table, recency_bins)
  n_recency <- if (length(recency_bins) == 1) {
    recency_bins
  } else {
    length(recency_bins) + 1
  }

  rlevels <-
    seq_len(n_recency) %>%
    rev()

  data <- use_series(rfm_table, rfm)
  data$recency_score <- factor(data$recency_score, levels = rlevels)

  return(data)

}

#' @importFrom dplyr rename
rfm_order_dist_data <- function(rfm_table) {
  rfm_table %>%
    use_series(rfm) %>%
    group_by(transaction_count) %>%
    summarise(n = n()) %>%
    rename(segment = transaction_count)
}

#' @importFrom magrittr multiply_by
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

#' @importFrom dplyr arrange
#' @importFrom rlang :=
rfm_prep_median <- function(rfm_segment_table, metric) {

  rfm_segment_table %>%
    select(segment, {{ metric }}) %>%
    group_by(segment) %>%
    summarise({{ metric }} := median({{ metric }})) %>%
    arrange({{ metric }})

}

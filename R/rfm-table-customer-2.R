#' @export
#' @rdname rfm_table_customer
#' @usage NULL
#'
rfm_table_customer_2 <- function(data = NULL, customer_id = NULL,
                                 n_transactions = NULL, latest_visit_date = NULL,
                                 total_revenue = NULL, analysis_date = NULL,
                                 recency_bins = 5, frequency_bins = 5,
                                 monetary_bins = 5, ...) {

  .Deprecated("rfm_table_customer()")

  col_names <- c("customer_id", "recency_days", "transaction_count", "amount")

  result <-
    data %>%
    mutate(
      recency_days = as.numeric(analysis_date - {{ latest_visit_date }},
                                units = "days")) %>%
    select({{ customer_id }}, recency_days, {{ n_transactions }},
           {{ total_revenue }}) %>%
    set_names(col_names)

  other_cols <-
    data %>%
    select(!c({{ latest_visit_date }}, {{ n_transactions }},
              {{ total_revenue }})) %>%
    rename(customer_id = {{ customer_id }})

  out <- rfm_prep_bins(result, recency_bins, frequency_bins, monetary_bins,
                       analysis_date, other_cols)
  class(out) <- c("rfm_table_customer", "tibble", "data.frame")
  return(out)

}


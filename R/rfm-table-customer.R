#' RFM table (customer data)
#'
#' Recency, frequency, monetary and RFM score.
#'
#' @param data A \code{data.frame} or \code{tibble}.
#' @param customer_id Unique id of the customer.
#' @param n_transactions Number of transactions/orders.
#' @param recency_days Number of days since the last transaction.
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
#' analysis_date <- as.Date('2007-01-01')
#' rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
#' recency_days, revenue, analysis_date)
#'
#' # access rfm table
#' result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
#' recency_days, revenue, analysis_date)
#' result$rfm
#'
#' # using custom threshold 
#' rfm_table_customer(rfm_data_customer, customer_id, number_of_orders, 
#' recency_days, revenue, analysis_date, recency_bins = c(115, 181, 297, 482), 
#' frequency_bins = c(4, 5, 6, 8), monetary_bins = c(256, 382, 506, 666))
#'
#' @export
#'
rfm_table_customer <- function(data = NULL, customer_id = NULL, n_transactions = NULL,
                            recency_days = NULL, total_revenue = NULL, analysis_date = NULL, recency_bins = 5,
                            frequency_bins = 5, monetary_bins = 5, ...) UseMethod("rfm_table_customer")

#' @export
#'
rfm_table_customer.default <- function(data = NULL, customer_id = NULL, n_transactions = NULL,
                                       recency_days = NULL, total_revenue = NULL, analysis_date = NULL, recency_bins = 5,
                                       frequency_bins = 5, monetary_bins = 5, ...) {

  cust_id     <- rlang::enquo(customer_id)
  order_count <- rlang::enquo(n_transactions)
  n_recency   <- rlang::enquo(recency_days)
  revenues    <- rlang::enquo(total_revenue)

  result <-
    data %>%
    dplyr::select(!! cust_id, !! n_recency, !! order_count, !! revenues) %>%
    set_names(c("customer_id", "recency_days", "transaction_count", "amount"))

  out <- rfm_prep_bins(result, recency_bins, frequency_bins, monetary_bins, analysis_date)

  class(out) <- c("rfm_table_customer", "tibble", "data.frame")
  return(out)

}



#' @export
#'
print.rfm_table_customer <- function(x, ...) {
  print(x$rfm)
}

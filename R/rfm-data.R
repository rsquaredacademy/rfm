#' RFM transaction data
#'
#' A dataset containing transactions of different customers.
#'
#' @format A tibble with 49.6 rows and 3 variables:
#' \describe{
#'   \item{order_date}{order date}
#'   \item{customer_id}{customer id}
#'   \item{revenue}{transaction amount}
#' }
#'
"rfm_data_orders"

#' RFM customer data
#'
#' A dataset containing customer level data.
#'
#' @format A tibble with 39,999 rows and 5 variables:
#' \describe{
#'   \item{customer_id}{Customer id.}
#'   \item{total_amount}{Total amount of all orders.}
#'   \item{most_recent_visit}{Date of the most recent transaction.}
#'   \item{number_of_purchases}{Total number of transactions/orders.}
#'   \item{purchase_interval}{Number of days since last transaction/order.}
#' }
#'
"rfm_data_customer"

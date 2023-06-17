#' @import magrittr
#' @import ggplot2
#' @import data.table
#' @importFrom stats median runif quantile reorder
#' @importFrom utils available.packages menu update.packages packageVersion
#' @importFrom utils install.packages
bins <- function(data, value, n_bins) {

  my_value   <- deparse(substitute(value))
  length_out <- n_bins + 1

  data[[my_value]] %>%
    quantile(probs = seq(0, 1, length.out = length_out)) %>%
    unname() %>%
    extract(c(-1, -length_out)) %>%
    add(1)

}

bins_lower <- function(data, value, bins) {

  my_value   <- deparse(substitute(value))

  data[[my_value]] %>%
    min() %>%
    append(bins)

}

bins_upper <- function(data, value, bins) {

  my_value <- deparse(substitute(value))

  data_max <-
    data[[my_value]] %>%
    max() %>%
    add(1)

  c(bins, data_max)
}


check_levels <- function(rfm_heatmap_data, column) {

  my_column <- deparse(substitute(column))

  rfm_heatmap_data[[my_column]] %>%
    as.factor() %>%
    levels() %>%
    as.vector() %>%
    as.integer()

}

modify_rfm <- function(rfm_heatmap_data, n_bins, check_levels) {

  missing           <- !(seq_len(n_bins) %in% check_levels)
  missing2          <- seq_len(n_bins)[missing]
  extra_data        <- expand.grid(missing2, seq_len(n_bins), 0)
  names(extra_data) <- names(rfm_heatmap_data)
  rbind(rfm_heatmap_data, extra_data)

}

try_pkg <- function(pkg) {
  tryCatch(packageVersion(pkg), error = function(e) NA)
}

to_title_case <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
}

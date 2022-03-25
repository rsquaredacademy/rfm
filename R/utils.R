#' @importFrom magrittr %>% %<>% use_series set_names extract extract2 add multiply_by
#' @import ggplot2
#' @import data.table
#' @importFrom stats median runif quantile
#' @importFrom utils available.packages menu update.packages packageVersion install.packages
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

  # dplyr::bind_rows(rfm_heatmap_data, extra_data)
  rbind(rfm_heatmap_data, extra_data)

}

check_suggests <- function(pkg) {

  pkg_flag <- tryCatch(packageVersion(pkg), error = function(e) NA)

  if (is.na(pkg_flag)) {

    msg <- message(paste0('\n', pkg, ' must be installed for this functionality.'))

    if (interactive()) {
      message(msg, "\nWould you like to install it?")
      if (menu(c("Yes", "No")) == 1) {
        install.packages(pkg)
      } else {
        stop(msg, call. = FALSE)
      }
    } else {
      stop(msg, call. = FALSE)
    }
  }

}

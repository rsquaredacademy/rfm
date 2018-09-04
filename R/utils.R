#' @importFrom dplyr enquo bind_rows
#' @importFrom stats quantile
#' @importFrom magrittr extract add %<>% %>% use_series
#' @importFrom purrr prepend
#' @importFrom assertthat are_equal
#' @importFrom forcats fct_unique
bins <- function(data, value, n_bins) {

  my_value   <- enquo(value)
  length_out <- n_bins + 1

  data %>%
    pull(!! my_value) %>%
    quantile(probs = seq(0, 1, length.out = length_out)) %>%
    unname() %>%
    `extract`(c(-1, -length_out)) %>%
    add(1)

}

bins_lower <- function(data, value, bins) {

  my_value <- enquo(value)

  data %>%
    pull(!! my_value) %>%
    min() %>%
    append(bins)

}

bins_upper <- function(data, value, bins) {

  my_value <- enquo(value)

  data %>%
    pull(!! my_value) %>%
    max() %>%
    add(1) %>%
    prepend(bins)

}


check_levels <- function(heatmap_data, column) {

  my_column <- enquo(column)

  heatmap_data %>%
    pull(!! my_column) %>%
    as.factor() %>%
    fct_unique() %>%
    as.vector() %>%
    as.integer()

}

modify_rfm <- function(heatmap_data, n_bins, check_levels) {

  missing           <- !(seq_len(n_bins) %in% check_levels)
  missing2          <- seq_len(n_bins)[missing]
  extra_data        <- expand.grid(missing2, seq_len(n_bins), 0)
  names(extra_data) <- names(heatmap_data)

  heatmap_data %<>%
    bind_rows(extra_data)

}

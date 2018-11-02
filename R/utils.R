#' @importFrom magrittr %>% %<>%
bins <- function(data, value, n_bins) {

  my_value   <- rlang::enquo(value)
  length_out <- n_bins + 1

  data %>%
    dplyr::pull(!! my_value) %>%
    stats::quantile(probs = seq(0, 1, length.out = length_out)) %>%
    unname() %>%
    magrittr::extract(c(-1, -length_out)) %>%
    magrittr::add(1)

}

bins_lower <- function(data, value, bins) {

  my_value <- rlang::enquo(value)

  data %>%
    dplyr::pull(!! my_value) %>%
    min() %>%
    append(bins)

}

bins_upper <- function(data, value, bins) {

  my_value <- rlang::enquo(value)

  data %>%
    dplyr::pull(!! my_value) %>%
    max() %>%
    magrittr::add(1) %>%
    purrr::prepend(bins)

}


check_levels <- function(rfm_heatmap_data, column) {

  my_column <- rlang::enquo(column)

  rfm_heatmap_data %>%
    dplyr::pull(!! my_column) %>%
    as.factor() %>%
    forcats::fct_unique() %>%
    as.vector() %>%
    as.integer()

}

modify_rfm <- function(rfm_heatmap_data, n_bins, check_levels) {

  missing           <- !(seq_len(n_bins) %in% check_levels)
  missing2          <- seq_len(n_bins)[missing]
  extra_data        <- expand.grid(missing2, seq_len(n_bins), 0)
  names(extra_data) <- names(rfm_heatmap_data)

  dplyr::bind_rows(rfm_heatmap_data, extra_data)

}

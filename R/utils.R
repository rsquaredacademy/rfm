#' @importFrom dplyr enquo bind_rows
#' @importFrom stats quantile
#' @importFrom magrittr extract add %<>% %>% use_series
#' @importFrom purrr prepend
#' @importFrom assertthat are_equal
#' @importFrom forcats fct_unique
bins <- function(data, value, n_bins) {

  my_value <- enquo(value)

  length_out <- n_bins + 1
  result <- data %>%
    pull(!!my_value) %>%
    quantile(probs = seq(0, 1, length.out = length_out)) %>%
    unname() %>%
    `extract`(c(-1, -length_out)) %>%
    add(1)

  return(result)

}

bins_lower <- function(data, value, bins) {

  my_value <- enquo(value)

  result <- data %>%
    pull(!!my_value) %>%
    min() %>%
    append(bins)

  return(result)

}

bins_upper <- function(data, value, bins) {

  my_value <- enquo(value)

  result <- data %>%
    pull(!!my_value) %>%
    max() %>%
    add(1) %>%
    prepend(bins)

  return(result)

}

heatmap_data <- function(rfm_table) {

  result <- rfm_table %>%
    use_series(rfm) %>%
    group_by(frequency_score, recency_score) %>%
    select(frequency_score, recency_score, amount) %>%
    summarise(monetary = mean(amount))

  l_frequency <- check_levels(result, frequency_score)
  l_recency <- check_levels(result, recency_score)

  levels_frequency <- check_levels(result, frequency_score) %>% length
  levels_recency <- check_levels(result, recency_score) %>% length

  f_frequency <- rfm_table %>%
    use_series(frequency_bins)

  if (!are_equal(levels_frequency, f_frequency)) {
    result %<>%
      modify_rfm(., f_frequency, l_frequency)
  }

  r_recency <- rfm_table %>%
    use_series(recency_bins)

  if (!are_equal(levels_recency, r_recency)) {
    result %<>%
      modify_rfm(., r_recency, l_recency)
  }



  return(result)

}

check_levels <- function(heatmap_data, column) {

  my_column <- enquo(column)

  result <- heatmap_data %>%
    pull(!!my_column) %>%
    as.factor() %>%
    fct_unique() %>%
    as.vector() %>%
    as.integer()

  return(result)

}

modify_rfm <- function(heatmap_data, n_bins, check_levels) {

  missing <- !(seq_len(n_bins) %in% check_levels)
  missing2 <- seq_len(n_bins)[missing]
  extra_data <- expand.grid(missing2, seq_len(n_bins), 0)
  names(extra_data) <- names(heatmap_data)
  heatmap_data %<>%
    bind_rows(extra_data)

  return(heatmap_data)

}

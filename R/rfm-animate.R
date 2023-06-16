data_animate_order_dist <- function(data) {
  n_groups <- length(data$n)

  gap <- data$n / 9
  start <- rep(0, n_groups)
  value <- start
  for (i in seq_len(9)) {
    n <- start + gap
    value <- c(value, n)
    start <- n
  }

  data.frame(segment = rep(data$transaction_count, 10),
             n = round(value),
             frame = rep(letters[1:10], each = n_groups))
}

rfm_animate_order_dist <- function(p) {
  p +
    transition_states(
      frame,
      transition_length = 10,
      state_length = 1,
      wrap = FALSE
    ) +
    ease_aes('linear')
}

data_animate_segment_summary <- function(data, metric) {
  n_groups <- length(data$segment)

  gap <- data[[metric]] / 9
  start <- rep(0, n_groups)
  value <- start
  for (i in seq_len(9)) {
    n <- start + gap
    value <- c(value, n)
    start <- n
  }

  result <- data.frame(segment = rep(data$segment, 10),
             n = round(value),
             frame = rep(letters[1:10], each = n_groups))

  names(result) <- c("segment", metric, "frame")
  result
}

rfm_animate_segment_summary <- function(p) {
  p +
    transition_states(
      frame,
      transition_length = 10,
      state_length = 1,
      wrap = FALSE
    ) +
    ease_aes('linear')
}

data_animate_revenue_dist <- function(data) {
  n_groups <- length(data$share)

  gap <- data$share / 9
  start <- rep(0, n_groups)
  value <- start
  for (i in seq_len(9)) {
    n <- start + gap
    value <- c(value, n)
    start <- n
  }

  data.frame(segment = rep(data$segment, 10),
             category = rep(data$category, 10),
             share = round(value, 2),
             frame = rep(letters[1:10], each = n_groups))
}

rfm_animate_revenue_dist <- function(p) {
  p +
    transition_states(
      frame,
      transition_length = 10,
      state_length = 1,
      wrap = FALSE
    ) +
    ease_aes('linear')
}
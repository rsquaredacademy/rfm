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

  data.frame(transaction_count = rep(data$transaction_count, 10),
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

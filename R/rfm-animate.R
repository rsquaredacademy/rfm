rfm_animate_data <- function(data, metric) {
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
                       n = round(value, 2),
                       frame = rep(letters[1:10], each = n_groups))

  names(result) <- c("segment", metric, "frame")
  result
}

rfm_animate_plot <- function(p) {
  p +
    gganimate::transition_states(
      frame,
      transition_length = 10,
      state_length = 1,
      wrap = FALSE
    ) +
    gganimate::ease_aes('linear')
}

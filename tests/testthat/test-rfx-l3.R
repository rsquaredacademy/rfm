test_that("mixed bins match strict boundary counts independently (L3)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[6:1], orders = c(1, 2, 2, 4, 5, 8),
                  days = c(0, .25, .5, .5, 1, 2),
                  revenue = c(-.5, 0, .25, .5, .5, 1))
  oracle <- function(values, spec) {
    if (length(spec) == 1) {
      cuts <- quantile(values, (seq_len(spec - 1)) / spec, names = FALSE)
      vapply(values, function(value) 1L + sum(value > cuts), integer(1))
    } else {
      vapply(values, function(value) 1L + sum(value >= spec), integer(1))
    }
  }
  specs <- list(1, 3, 5, c(.25, .5))
  for (r in specs) {
    for (f in specs) {
      for (m in specs) {
        out <- rfm_table_customer(x, id, orders, days, revenue, ad,
                                  recency_bins = r, frequency_bins = f,
                                  monetary_bins = m)$rfm
        nr <- if (length(r) == 1) r else length(r) + 1
        expect_equal(out$customer_id, x$id)
        expect_equal(out$amount, x$revenue)
        expect_equal(out$recency_days, x$days)
        expect_equal(out$transaction_count, as.integer(x$orders))
        expect_equal(out$recency_score, nr + 1 - oracle(x$days, r))
        expect_equal(out$frequency_score, oracle(x$orders, f))
        expect_equal(out$monetary_score, oracle(x$revenue, m))
      }
    }
  }
})

test_that("remaining deprecated plot aliases retain supplied labels (L3)", {
  skip_on_cran()
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5, revenue = 1:5)
  t <- rfm_table_customer(x, id, orders, days, revenue, ad)
  expect_warning(p <- rfm_heatmap(t, xaxis_title = "X", yaxis_title = "Y",
                                  print_plot = FALSE), "rfm_plot_heatmap")
  expect_equal(p$labels$x, "X")
  expect_equal(p$labels$y, "Y")
  expect_equal(nrow(ggplot2::ggplot_build(p)$data[[1]]), 25L)
  expect_warning(p <- rfm_bar_chart(t, xaxis_title = "X", yaxis_title = "Y",
                                    print_plot = FALSE), "rfm_plot_bar_chart")
  expect_equal(p$labels$x, "X")
  expect_equal(p$labels$y, "Y")
  expect_warning(p <- rfm_order_dist(t, xaxis_title = "X", yaxis_title = "Y",
                                     print_plot = FALSE), "rfm_plot_order_dist")
  expect_equal(p$labels$x, "X")
  expect_equal(p$labels$y, "Y")
  expect_equal(sum(ggplot2::ggplot_build(p)$data[[1]]$y), 5)
})

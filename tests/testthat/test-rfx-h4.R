test_that("heatmaps preserve observed missing means and fill only absent pairs (H4)", {
  ad <- as.Date("2026-01-10")
  x <- expand.grid(days = c(0, 3, 6), orders = c(1L, 4L, 7L))
  x$id <- seq_len(nrow(x))
  x$revenue <- 10
  x$revenue[1] <- NA_real_
  heat <- function(x) {
    rfm_heatmap_data(rfm_table_customer(
      x, id, orders, days, revenue, ad,
      recency_bins = 3, frequency_bins = 3, monetary_bins = c(5, 20)
    ))
  }
  h <- heat(x)
  expect_equal(h$monetary[h$frequency_score == 1 & h$recency_score == 3], NA_real_)
  h <- heat(x[-9, ])
  expect_equal(h$monetary[h$frequency_score == 1 & h$recency_score == 3], NA_real_)
  expect_equal(h$monetary[h$frequency_score == 3 & h$recency_score == 1], 0)
  expect_equal(h$monetary[h$frequency_score == 2 & h$recency_score == 2], 10)
  expect_equal(nrow(h), 9L)
})

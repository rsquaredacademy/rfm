test_that("automatic scores preserve currency units (H3)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5,
                  revenue = (1:5) / 10)
  score <- function(x) rfm_table_customer(x, id, orders, days, revenue, ad)
  expect_equal(score(x)$rfm$monetary_score, 1:5)
  expect_equal(score(transform(x, revenue = revenue * 100))$rfm$monetary_score,
               1:5)
  expect_equal(score(x)$rfm$frequency_score, 1:5)
  expect_equal(score(x)$rfm$recency_score, 5:1)
  expect_equal(score(x)$threshold$monetary_upper, c(.18, .26, .34, .42, .5))
})

test_that("quantile boundaries are right closed and ties stay together (H3)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:6], orders = 1:6, days = 1:6,
                  revenue = (1:6) / 10)
  # Type-7 quintiles of 1:6 are exactly 2, 3, 4, 5.
  out <- rfm_table_customer(x, id, orders, days, revenue, ad)
  expect_equal(out$rfm$recency_score, c(5, 5, 4, 3, 2, 1))
  expect_equal(out$rfm$frequency_score, c(1, 1, 2, 3, 4, 5))
  expect_equal(out$rfm$monetary_score, c(1, 1, 2, 3, 4, 5))
  expect_equal(out$threshold$recency_lower, c(1, 2, 3, 4, 5))
  expect_equal(out$threshold$recency_upper, 2:6)

  x$date <- ad - x$days
  date_out <- suppressWarnings(rfm_table_customer_2(
    x, id, orders, date, revenue, ad
  ))
  expect_equal(date_out$rfm$monetary_score, c(1, 1, 2, 3, 4, 5))
  expect_equal(rfm_table_customer(x, id, orders, date, revenue, ad)$rfm$recency_score,
               c(5, 5, 4, 3, 2, 1))

  tx <- x[rep(seq_len(nrow(x)), x$orders), c("id", "date", "revenue")]
  tx$revenue <- rep(x$revenue / x$orders, x$orders)
  tx_out <- rfm_table_order(tx, id, date, revenue, ad)$rfm
  expect_equal(tx_out$amount, x$revenue)
  expect_equal(tx_out$frequency_score, c(1, 1, 2, 3, 4, 5))
  expect_equal(tx_out$recency_score, c(5, 5, 4, 3, 2, 1))
  expect_equal(tx_out$monetary_score, c(1, 1, 2, 3, 4, 5))

  x$orders <- c(1, 1, 1, 2, 2, 3)
  tied <- rfm_table_customer(x, id, orders, days, revenue, ad)$rfm
  expect_equal(tied$frequency_score, c(1, 1, 1, 3, 3, 5))
  one <- rfm_table_customer(x, id, orders, days, revenue, ad,
                            recency_bins = 1, frequency_bins = 1, monetary_bins = 1)
  expect_equal(one$rfm$rfm_score, rep(111, 6))
})

test_that("custom thresholds remain lower inclusive (H3)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:6], orders = 1:6, days = 1:6, revenue = 1:6)
  out <- rfm_table_customer(x, id, orders, days, revenue, ad,
                            recency_bins = c(2, 4), frequency_bins = c(2, 4),
                            monetary_bins = c(2, 4))$rfm
  expect_equal(out$recency_score, c(3, 2, 2, 1, 1, 1))
  expect_equal(out$frequency_score, c(1, 2, 2, 3, 3, 3))
  expect_equal(out$monetary_score, c(1, 2, 2, 3, 3, 3))
})

test_that("values exactly on a cut point stay in the lower bin for every bin count (rfxx M1)", {
  ad <- as.Date("2026-01-10")
  d <- data.frame(id = sprintf("c%02d", 1:31), orders = 1L, days = 1L,
                  revenue = as.numeric(1:31))
  k <- rfm_table_customer(d, id, orders, days, revenue, ad, monetary_bins = 6)
  # exact 5/6 quantile of 1:31 is 26, so 26 scores 5, not 6
  expect_equal(k$rfm$monetary_score[k$rfm$customer_id == "c26"], 5)

  for (n in 2:12) {
    x <- as.numeric(1:31)
    q <- stats::quantile(x, probs = seq_len(n - 1) / n, type = 7, names = FALSE)
    expect_equal(bins(data.frame(v = x), "v", n), q)
    expected <- 1 + vapply(x, function(v) sum(v > q), numeric(1))
    got <- rfm_table_customer(d, id, orders, days, revenue, ad,
                              monetary_bins = n)$rfm$monetary_score
    expect_equal(as.numeric(got), expected)
  }
})

test_that("several missing customer IDs get a clear message (rfxx L)", {
  ad <- as.Date("2026-01-10")
  d <- data.frame(id = c(NA, NA, "a"), orders = 1:3, days = 1:3, revenue = 1:3)
  expect_error(rfm_table_customer(d, id, orders, days, revenue, ad),
               "more than one missing value")
})

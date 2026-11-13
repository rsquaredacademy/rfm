test_that("transaction metadata cannot multiply customer totals (H2)", {
  ad <- as.Date("2026-01-10")
  orders <- data.frame(
    id = c("a", "a", "b"), date = ad - c(2, 1, 1),
    revenue = c(10, 20, 40), product = c("X", "Y", "X"),
    region = c("North", "North", "South"), channel = c("web", "shop", "web")
  )
  expect_message(
    out <- rfm_table_order(orders, id, date, revenue, ad)$rfm,
    "product.*channel"
  )
  expect_equal(out$customer_id, c("a", "b"))
  expect_equal(out$amount, c(30, 40))
  expect_equal(out$transaction_count, c(2L, 1L))
  expect_equal(out$recency_days, c(1, 1))
  expect_equal(sum(out$amount), sum(orders$revenue))
  expect_equal(sum(out$transaction_count), nrow(orders))
  expect_equal(nrow(out), length(unique(orders$id)))
  expect_equal(out$region, c("North", "South"))
  expect_false(any(c("product", "channel") %in% names(out)))

  orders$product <- c("X", "X", "Y")
  orders$channel <- NULL
  orders$region <- c(NA, NA, "South")
  expect_no_message(out <- rfm_table_order(orders, id, date, revenue, ad)$rfm)
  expect_equal(out$product, c("X", "Y"))
  expect_equal(out$region, c(NA, "South"))
  expect_equal(sum(out$amount), 70)
  orders$product[1] <- NA
  expect_message(out <- rfm_table_order(orders, id, date, revenue, ad)$rfm,
                 "product")
  expect_equal(nrow(out), 2L)
})

test_that("customer input requires unique IDs on both date paths (H2)", {
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = c("a", "a"), orders = 1L, days = 1, revenue = 10)
  expect_error(rfm_table_customer(x, id, orders, days, revenue, ad),
               "[Dd]uplicat.*customer")
  x$date <- ad - x$days
  expect_error(rfm_table_customer(x, id, orders, date, revenue, ad),
               "[Dd]uplicat.*customer")
  expect_error(suppressWarnings(rfm_table_customer_2(
    x, id, orders, date, revenue, ad
  )), "[Dd]uplicat.*customer")
})

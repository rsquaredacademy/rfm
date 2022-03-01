context("rfm_table")

test_that("output from rfm_table_order is as expected", {

  analysis_date <- as.Date("2006-12-31")
  result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 4906

  expect_equal(actual, expected)

})

test_that("output from rfm_table_order is as expected when using custom thresholds", {

  analysis_date <- as.Date("2006-12-31")
  result <-  rfm_table_order(rfm_data_orders, customer_id, order_date, revenue,
                             analysis_date, recency_bins = c(115, 181, 297, 482),
                             frequency_bins = c(4, 5, 6, 8),
                             monetary_bins = c(256, 382, 506, 666))

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 4906

  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer is as expected", {

  analysis_date <- as.Date('2007-01-01')
  result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
  	recency_days, revenue, analysis_date)

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer is as expected when using custom
          thresholds", {

  analysis_date <- as.Date('2007-01-01')
  result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
                               recency_days, revenue, analysis_date,
                               recency_bins = c(115, 181, 297, 482),
                               frequency_bins = c(4, 5, 6, 8),
                               monetary_bins = c(256, 382, 506, 666))

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer_2 is as expected", {

  analysis_date <- as.Date('2007-01-01')
	result <- rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders,
		most_recent_visit, revenue, analysis_date)

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)
})

test_that("output from rfm_table_customer_2 is as expected when using custom
          thresholds", {

  analysis_date <- as.Date('2007-01-01')
  result <- rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders,
                                 most_recent_visit, revenue, analysis_date,
                                 recency_bins = c(115, 181, 297, 482),
                                 frequency_bins = c(4, 5, 6, 8),
                                 monetary_bins = c(256, 382, 506, 666))

  actual <-
    result %>%
    use_series(rfm) %>%
    extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)
})

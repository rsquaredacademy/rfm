test_that("output from rfm_table_order is as expected", {

  analysis_date <- as.Date("2006-12-31")
  result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)

  actual <-
    result %>%
    use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
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
    magrittr::extract2("transaction_count") %>%
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
    magrittr::extract2("transaction_count") %>%
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
    magrittr::extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer is as expected when using dates", {

  analysis_date <- as.Date('2007-01-01')
	result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
		most_recent_visit, revenue, analysis_date)

  actual <-
    result %>%
    use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)
})

test_that("output from rfm_table_customer is as expected when using dates and 
           custom thresholds", {

  analysis_date <- as.Date('2007-01-01')
  result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
                                 most_recent_visit, revenue, analysis_date,
                                 recency_bins = c(115, 181, 297, 482),
                                 frequency_bins = c(4, 5, 6, 8),
                                 monetary_bins = c(256, 382, 506, 666))

  actual <-
    result %>%
    use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
    sum()

  expected <- 393223

  expect_equal(actual, expected)
})

test_that("rfm_table_customer handles date recency without recency_days (#111)", {

  analysis_date <- as.Date("2007-01-01")
  customer_data <- rfm_data_customer[
    , c("customer_id", "revenue", "most_recent_visit", "number_of_orders")
  ]

  without_days <- rfm_table_customer(
    customer_data, customer_id, number_of_orders, most_recent_visit,
    revenue, analysis_date
  )
  with_days <- rfm_table_customer(
    rfm_data_customer, customer_id, number_of_orders, most_recent_visit,
    revenue, analysis_date
  )

  score_cols <- c(
    "customer_id", "recency_score", "frequency_score", "monetary_score",
    "rfm_score", "transaction_count", "amount"
  )

  expect_true("recency_days" %in% names(without_days$rfm))
  expect_equal(without_days$rfm[score_cols], with_days$rfm[score_cols])
})

test_that("rfm_table_customer_2 works and warns about deprecation (#112)", {

  analysis_date <- as.Date("2007-01-01")

  expect_warning(
    result <- rfm_table_customer_2(
      rfm_data_customer, customer_id, number_of_orders, most_recent_visit,
      revenue, analysis_date
    ),
    "deprecated"
  )

  expect_s3_class(result, "rfm_table_customer")
  expect_equal(sum(result$rfm$transaction_count), 393223)
  expect_equal(nrow(result$rfm), nrow(rfm_data_customer))
})

test_that("rfm_table_order supports unequal bin counts (#113)", {

  analysis_date <- as.Date("2006-12-31")

  unequal <- rfm_table_order(
    rfm_data_orders, customer_id, order_date, revenue, analysis_date,
    recency_bins = 5, frequency_bins = 4, monetary_bins = 3
  )

  expect_setequal(unequal$rfm$recency_score, 1:5)
  expect_setequal(unequal$rfm$frequency_score, 1:4)
  expect_setequal(unequal$rfm$monetary_score, 1:3)

  expect_equal(nrow(unequal$threshold), 5)
  expect_true(all(is.na(unequal$threshold[5, c(
    "frequency_lower", "frequency_upper", "monetary_lower", "monetary_upper"
  )])))

  recency_ref <- rfm_table_order(
    rfm_data_orders, customer_id, order_date, revenue, analysis_date,
    recency_bins = 5, frequency_bins = 5, monetary_bins = 5
  )
  frequency_ref <- rfm_table_order(
    rfm_data_orders, customer_id, order_date, revenue, analysis_date,
    recency_bins = 4, frequency_bins = 4, monetary_bins = 4
  )
  monetary_ref <- rfm_table_order(
    rfm_data_orders, customer_id, order_date, revenue, analysis_date,
    recency_bins = 3, frequency_bins = 3, monetary_bins = 3
  )

  expect_equal(unequal$rfm$recency_score, recency_ref$rfm$recency_score)
  expect_equal(unequal$rfm$frequency_score, frequency_ref$rfm$frequency_score)
  expect_equal(unequal$rfm$monetary_score, monetary_ref$rfm$monetary_score)
})

test_that("rfm_table_customer supports unequal bin counts (#113)", {

  analysis_date <- as.Date("2007-01-01")

  unequal <- rfm_table_customer(
    rfm_data_customer, customer_id, number_of_orders, recency_days, revenue,
    analysis_date, recency_bins = 5, frequency_bins = 4, monetary_bins = 3
  )

  expect_setequal(unequal$rfm$recency_score, 1:5)
  expect_setequal(unequal$rfm$frequency_score, 1:4)
  expect_setequal(unequal$rfm$monetary_score, 1:3)

  expect_equal(nrow(unequal$threshold), 5)
  expect_true(all(is.na(unequal$threshold[5, c(
    "frequency_lower", "frequency_upper", "monetary_lower", "monetary_upper"
  )])))

  recency_ref <- rfm_table_customer(
    rfm_data_customer, customer_id, number_of_orders, recency_days, revenue,
    analysis_date, recency_bins = 5, frequency_bins = 5, monetary_bins = 5
  )
  frequency_ref <- rfm_table_customer(
    rfm_data_customer, customer_id, number_of_orders, recency_days, revenue,
    analysis_date, recency_bins = 4, frequency_bins = 4, monetary_bins = 4
  )
  monetary_ref <- rfm_table_customer(
    rfm_data_customer, customer_id, number_of_orders, recency_days, revenue,
    analysis_date, recency_bins = 3, frequency_bins = 3, monetary_bins = 3
  )

  expect_equal(unequal$rfm$recency_score, recency_ref$rfm$recency_score)
  expect_equal(unequal$rfm$frequency_score, frequency_ref$rfm$frequency_score)
  expect_equal(unequal$rfm$monetary_score, monetary_ref$rfm$monetary_score)
})

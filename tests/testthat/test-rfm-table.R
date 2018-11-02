context("rfm_table")

test_that("output from rfm_table_order is as expected", {

  analysis_date <- lubridate::as_date("2006-12-31", tz = "UTC")
  result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  
  actual <- 
    result %>%
    magrittr::use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
    sum()
  
  expected <- 4906
  
  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer is as expected", {

  analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
  result <- rfm_table_customer(rfm_data_customer, customer_id, number_of_orders,
  	recency_days, revenue, analysis_date)
  
  actual <- 
    result %>%
    magrittr::use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
    sum()

  expected <- 393223
  
  expect_equal(actual, expected)

})

test_that("output from rfm_table_customer_2 is as expected", {

  analysis_date <- lubridate::as_date('2007-01-01', tz = 'UTC')
	result <- rfm_table_customer_2(rfm_data_customer, customer_id, number_of_orders, 
		most_recent_visit, revenue, analysis_date)
  
  actual <- 
    result %>%
    magrittr::use_series(rfm) %>%
    magrittr::extract2("transaction_count") %>%
    sum()
  
  expected <- 393223
  
  expect_equal(actual, expected)
})
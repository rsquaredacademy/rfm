context('rfm_table')

test_that('output from rfm_table is as expected', {

  analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
  result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
  actual <- result %>%
    use_series(rfm) %>%
    extract2('transaction_count') %>%
    sum
  expected <- 4906
  expect_equal(actual, expected)

})

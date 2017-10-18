context('rfm_table')

test_that('output from rfm_table is as expected', {

  analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
  result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
  actual <- result %>%
    use_series(rfm) %>%
    extract2('transaction_count') %>%
    sum
  expected <- 25613
  expect_equal(actual, expected)

})

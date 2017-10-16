context('rfm_table')

test_that('output from rfm_table is as expected', {

  analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
  result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
  actual <- result %>%
    use_series(rfm) %>%
    extract2('recency_days') %>%
    mean
  expected <- 51.66
  expect_equal(round(actual, 2), expected)

})

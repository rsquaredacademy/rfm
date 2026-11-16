test_that('Champions summary follows the right-closed automatic scores', {

  analysis_date <- as.Date("2006-12-31")

  rfm_result <-
    rfm_table_order(
      rfm_data_orders,
      customer_id,
      order_date,
      revenue,
      analysis_date
    )

  segment_names <- c(
    "Champions", "Loyal Customers", "Potential Loyalist",
    "New Customers", "Promising", "Need Attention", "About To Sleep",
    "At Risk", "Can't Lose Them", "Lost"
  )

  recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
  recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
  frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
  frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
  monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
  monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)

  segment <- rfm_segment(
    rfm_result,
    segment_names,
    recency_lower,
    recency_upper,
    frequency_lower,
    frequency_upper,
    monetary_lower,
    monetary_upper
  )

  segments <- rfm_segment_summary(segment)

  expect_equal(segments[segments$segment == "Champions",][[2]], 159)
  expect_equal(segments[segments$segment == "Champions",][[3]], 1240)
  expect_equal(segments[segments$segment == "Champions",][[4]], 120684)
  expect_equal(segments[segments$segment == "Champions",]$aov, 97.33)

})

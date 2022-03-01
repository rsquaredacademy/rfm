context("test-rfm-segment.R")

test_that('first 10 rows of output from rfm_segment are as expected', {

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

  actual <- rfm_segment(
    rfm_result,
    segment_names,
    recency_lower,
    recency_upper,
    frequency_lower,
    frequency_upper,
    monetary_lower,
    monetary_upper
  )

  segments <- rfm_segment_summary(actual)

  expected <- structure(list(customer_id = c(
    "Abbey O'Reilly DVM", "Add Senger",
    "Aden Lesch Sr.", "Admiral Senger", "Agness O'Keefe", "Aileen Barton",
    "Ailene Hermann", "Aiyanna Bruen PhD", "Ala Schmidt DDS", "Alannah Borer"
  ), segment = c(
    "Loyal Customers", "Potential Loyalist", "Potential Loyalist",
    "Loyal Customers", "Champions", "Champions", "Loyal Customers",
    "Potential Loyalist", "About To Sleep", "Lost"
  )), row.names = c(
    NA,
    -10L
  ), class = c("tbl_df", "tbl", "data.frame"))

  expect_equal(
    actual[1:10, c("customer_id", "segment")],
    expected
  )

  expect_equal(
    segments %>%
      filter(segment == "Champions") %>%
      extract2(2), 
    158
  )

  expect_equal(
    segments %>%
      filter(segment == "Champions") %>%
      extract2(3), 
    1234
  )

  expect_equal(
    segments %>%
      filter(segment == "Champions") %>%
      extract2(4), 
    120178
  )

})

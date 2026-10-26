test_that('output from bins is as expected', {

  actual <- bins(mtcars, "mpg", 5)
  expected <- c(16.20, 18.92, 22.00, 25.08)
  expect_equal(actual, expected)

})

test_that('output from bins_lower is as expected', {

  actual <- bins_lower(mtcars, "mpg", 5)
  expected <- c(10.4, 5.0)
  expect_equal(actual, expected)
})

test_that('output from bins_upper is as expected', {

  actual <- bins_upper(mtcars, "mpg", 5)
  expected <- c(5.0, 34.9)
  expect_equal(actual, expected)
})

test_that('output from rfm_heatmap_data is as expected', {

  analysis_date <- as.Date('2006-12-31')

  actual <-
    rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date) %>%
    rfm_heatmap_data() %>%
    use_series(monetary) %>%
    sum() %>%
    round()

  expected <- 12634
  expect_equal(actual, expected)

})

test_that('output from check_levels is as expected', {

  analysis_date <- as.Date('2006-12-31')

  actual <-
    rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date) %>%
    rfm_heatmap_data() %>%
    check_levels(column = "recency_score")

  expected <- c(1, 2, 3, 4, 5)
  expect_equal(actual, expected)

})

test_that('output from modify_rfm is as expected', {

  analysis_date <- as.Date('2006-12-31')

  heat <-
    rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date) %>%
    rfm_heatmap_data()

  clevel <- check_levels(heat, column = 2)

  actual <-
    modify_rfm(heat, 5, clevel) %>%
    use_series(monetary) %>%
    sum() %>%
    round()

  expected <- 12634
  expect_equal(actual, expected)

})

test_that('rfm_heatmap_data supports custom thresholds (#114)', {

  analysis_date <- as.Date('2006-12-31')

  heat <-
    rfm_table_order(
      rfm_data_orders, customer_id, order_date, revenue, analysis_date,
      recency_bins = c(115, 181, 297, 482),
      frequency_bins = c(4, 5, 6, 8),
      monetary_bins = c(256, 382, 506, 666)
    ) %>%
    rfm_heatmap_data()

  pairs <- heat[c("recency_score", "frequency_score")]

  expect_equal(nrow(pairs), 25)
  expect_false(anyDuplicated(pairs) > 0)
  expect_setequal(pairs$recency_score, 1:5)
  expect_setequal(pairs$frequency_score, 1:5)
  expect_equal(
    nrow(unique(pairs)),
    nrow(expand.grid(
      recency_score = 1:5,
      frequency_score = 1:5
    ))
  )
})

test_that('rfm_heatmap_data creates each score pair once when both dimensions have gaps (#114 review)', {

  analysis_date <- as.Date('2006-12-31')

  heat <-
    rfm_table_order(
      rfm_data_orders, customer_id, order_date, revenue, analysis_date,
      recency_bins = c(115, 181, 297, 10000),
      frequency_bins = c(4, 100)
    ) %>%
    rfm_heatmap_data()

  pairs <- heat[c("recency_score", "frequency_score")]
  expected <- expand.grid(
    recency_score = 1:5,
    frequency_score = 1:3
  )

  expect_equal(nrow(pairs), 15)
  expect_false(anyDuplicated(pairs) > 0)
  expect_setequal(pairs$recency_score, expected$recency_score)
  expect_setequal(pairs$frequency_score, expected$frequency_score)
  expect_setequal(
    paste(pairs$recency_score, pairs$frequency_score),
    paste(expected$recency_score, expected$frequency_score)
  )
  expect_equal(sum(heat$monetary == 0), 7)
})

test_that('rfm_barchart_data uses the bin count of custom thresholds (#114 review)', {

  analysis_date <- as.Date('2006-12-31')

  custom <-
    rfm_table_order(
      rfm_data_orders, customer_id, order_date, revenue, analysis_date,
      recency_bins = c(115, 181, 297, 482),
      frequency_bins = c(4, 5, 6, 8),
      monetary_bins = c(256, 382, 506, 666)
    )

  expect_no_warning(bar <- rfm_barchart_data(custom))
  expect_equal(nlevels(bar$recency_score), 5L)
  expect_equal(levels(bar$recency_score), as.character(5:1))

  short <-
    rfm_table_order(
      rfm_data_orders, customer_id, order_date, revenue, analysis_date,
      recency_bins = c(115, 181), frequency_bins = c(4, 5),
      monetary_bins = c(256, 382)
    )

  expect_no_warning(bar_short <- rfm_barchart_data(short))
  expect_equal(nlevels(bar_short$recency_score), 3L)
  expect_equal(levels(bar_short$recency_score), as.character(3:1))
})

test_that('rfm_heatmap_data fills missing recency levels (#114)', {

  analysis_date <- as.Date('2006-12-31')

  heat <-
    rfm_table_order(
      rfm_data_orders, customer_id, order_date, revenue, analysis_date,
      recency_bins = c(115, 181, 297, 10000),
      frequency_bins = c(4, 5, 6, 8),
      monetary_bins = c(256, 382, 506, 666)
    ) %>%
    rfm_heatmap_data()

  pairs <- heat[c("recency_score", "frequency_score")]

  expect_equal(nrow(pairs), 25)
  expect_false(anyDuplicated(pairs) > 0)
  expect_setequal(pairs$recency_score, 1:5)
  expect_setequal(pairs$frequency_score, 1:5)
})

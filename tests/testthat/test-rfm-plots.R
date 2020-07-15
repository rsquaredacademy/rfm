context("test-rfm-plots.R")

test_that('output from rfm_bar_chart is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  p <- rfm_bar_chart(rfm_result)
  vdiffr::expect_doppelganger('rfm barchart', p)

})

test_that('output from rfm_rf_plot is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  p <- rfm_rf_plot(rfm_result)
  vdiffr::expect_doppelganger('rfm rfplot', p)

})

test_that('output from rfm_rm_plot is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  p <- rfm_rm_plot(rfm_result)
  vdiffr::expect_doppelganger('rfm rmplot', p)

})

test_that('output from rfm_fm_plot is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
  p <- rfm_fm_plot(rfm_result)
  vdiffr::expect_doppelganger('rfm fmplot', p)

})


test_that('output from rfm_heatmap is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  p <- rfm_heatmap(rfm_result)
  vdiffr::expect_doppelganger('rfm heatmap', p)

})

test_that('output from rfm_histograms is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  p <- rfm_histograms(rfm_result)
  vdiffr::expect_doppelganger('rfm histograms', p)

})

test_that('output from rfm_order_dist is as expected', {

  skip_on_cran()

  analysis_date <- lubridate::as_date('2006-12-31')
  rfm_result <- rfm_order <- rfm_table_order(rfm_data_orders, customer_id, order_date,
    revenue, analysis_date)
  p <- rfm_order_dist(rfm_result)
  vdiffr::expect_doppelganger('rfm orderdist', p)

})

analysis_date <- lubridate::as_date('2006-12-31')
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
revenue, analysis_date)

segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
  "New Customers", "Promising", "Need Attention", "About To Sleep",
  "At Risk", "Can't Lose Them", "Lost")

recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)

segments <- rfm_segment(rfm_result, segment_names, recency_lower,
recency_upper, frequency_lower, frequency_upper, monetary_lower,
monetary_upper)

test_that('output from rfm_plot_median_recency is as expected', {

  skip_on_cran()

  p <- rfm_plot_median_recency(segments)
  vdiffr::expect_doppelganger('rfm median recency', p)

})

test_that('output from rfm_plot_median_frequency is as expected', {

  skip_on_cran()

  p <- rfm_plot_median_frequency(segments)
  vdiffr::expect_doppelganger('rfm median frequency', p)

})

test_that('output from rfm_plot_median_monetary is as expected', {

  skip_on_cran()

  p <- rfm_plot_median_monetary(segments)
  vdiffr::expect_doppelganger('rfm median monetary', p)

})




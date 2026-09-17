analysis_date <- as.Date("2006-12-31")
rfm_result <- rfm_table_order(
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

segments <- rfm_segment(
  rfm_result,
  segment_names,
  recency_lower,
  recency_upper,
  frequency_lower,
  frequency_upper,
  monetary_lower,
  monetary_upper
)

segment_overview <- rfm_segment_summary(segments)
orig_requireNamespace <- base::requireNamespace

test_that("interactive plotting functions abort cleanly when plotly is missing", {
  testthat::with_mocked_bindings(
    {
      expect_error(rfm_plot_heatmap(rfm_result, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_histogram(rfm_result, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_order_dist(rfm_result, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_segment_summary(segment_overview, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_revenue_dist(segment_overview, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_recency(segments, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_frequency(segments, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_monetary(segments, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_segment(segment_overview, interactive = TRUE), class = "rlang_error")
      expect_error(rfm_plot_segment_scatter(segments, interactive = TRUE), class = "rlang_error")
    },
    requireNamespace = function(pkg, ...) {
      if (pkg == "plotly") FALSE else orig_requireNamespace(pkg, ...)
    },
    .package = "base"
  )
})

test_that("animated plotting functions abort cleanly when gganimate or gifski is missing", {
  testthat::with_mocked_bindings(
    {
      expect_error(rfm_plot_order_dist(rfm_result, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_segment_summary(segment_overview, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_revenue_dist(segment_overview, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_recency(segments, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_frequency(segments, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_median_monetary(segments, animate = TRUE), class = "rlang_error")
      expect_error(rfm_plot_segment_scatter(segments, animate = TRUE), class = "rlang_error")
    },
    requireNamespace = function(pkg, ...) {
      if (pkg %in% c("gganimate", "gifski")) FALSE else orig_requireNamespace(pkg, ...)
    },
    .package = "base"
  )
})

test_that("rfm_plot_segment aborts cleanly when treemapify is missing", {
  testthat::with_mocked_bindings(
    expect_error(rfm_plot_segment(segment_overview, interactive = FALSE), class = "rlang_error"),
    requireNamespace = function(pkg, ...) {
      if (pkg == "treemapify") FALSE else orig_requireNamespace(pkg, ...)
    },
    .package = "base"
  )
})

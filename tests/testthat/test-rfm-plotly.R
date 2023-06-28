analysis_date <- as.Date('2006-12-31')
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

my_segments <- rfm_segment_summary(segments)

test_that('interactive order distribution plot is as expected', {

  skip_on_cran()

  p <- rfm_plot_order_dist(rfm_result, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customer Distribution by Orders</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Orders</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Customers</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that('interactive heatmap is as expected', {

  skip_on_cran()

  p <- rfm_plot_heatmap(rfm_result, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$colorbar$title, "Mean Monetary Value")
  expect_equal(p$x$attrs[[1]]$colors,
               c("#F1EEF6", "#BDC9E1", "#74A9CF", "#2B8CBE", "#045A8D"))
  expect_equal(p$x$attrs[[1]]$type, "heatmap")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>RFM Heat Map</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Frequency Score</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Recency Score</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that('interactive histogram is as expected', {

  skip_on_cran()

  p <- rfm_plot_histogram(rfm_result, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$histnorm, "count")
  expect_true(p$x$attrs[[1]]$autobinx)
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$attrs[[1]]$marker$line$color, "white")
  expect_equal(p$x$attrs[[1]]$marker$line$width, 1.5)
  expect_equal(p$x$attrs[[1]]$type, "histogram")

  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Recency  Distribution</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Recency</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Count</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))
})

test_that("interactive segment summary plot is as expected", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Customers</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive segment summary plot is as expected when sorted", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, sort = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$categoryorder, "total descending")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Customers</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive segment summary plot sorted in descending order", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, sort = TRUE,
                                ascending = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$categoryorder, "total ascending")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Customers</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive segment summary plot flipped", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, flip = TRUE,
                                interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Customers</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive segment summary plot flipped sorted", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, flip = TRUE, sort = TRUE,
                                interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Customers</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$categoryorder, "total ascending")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive segment summary plot flipped sorted ascending", {
  skip_on_cran()

  p <- rfm_plot_segment_summary(my_segments, flip = TRUE, sort = TRUE,
                                ascending = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Customers  Distribution by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Customers</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$categoryorder, "total descending")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that('interactive revenue distribution plot', {

  skip_on_cran()

  p <- rfm_plot_revenue_dist(my_segments, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$name, "Revenue")
  expect_equal(p$x$attrs[[1]]$marker$color, "#3b5bdb")
  expect_equal(p$x$attrs[[2]]$type, "bar")
  expect_equal(p$x$attrs[[2]]$name, "Customers")
  expect_equal(p$x$attrs[[2]]$marker$color, "#91a7ff")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Revenue & Customer Distribution</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b></b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b></b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$ticksuffix, "%")
  expect_equal(p$x$layoutAttrs[[1]]$legend$x, 100)
  expect_equal(p$x$layoutAttrs[[1]]$legend$y, 0.5)
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))
  expect_snapshot(cat(p$x$attrs[[2]]$hovertext))
})

test_that('interactive revenue distribution plot flipped', {

  skip_on_cran()

  p <- rfm_plot_revenue_dist(my_segments, flip = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$name, "Revenue")
  expect_equal(p$x$attrs[[1]]$marker$color, "#3b5bdb")
  expect_equal(p$x$attrs[[2]]$type, "bar")
  expect_equal(p$x$attrs[[2]]$orientation, "h")
  expect_equal(p$x$attrs[[2]]$name, "Customers")
  expect_equal(p$x$attrs[[2]]$marker$color, "#91a7ff")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Revenue & Customer Distribution</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b></b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$ticksuffix, "%")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b></b>")
  expect_equal(p$x$layoutAttrs[[1]]$legend$x, 100)
  expect_equal(p$x$layoutAttrs[[1]]$legend$y, 0.5)
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))
  expect_snapshot(cat(p$x$attrs[[2]]$hovertext))
})

test_that('interactive segment plot', {

  skip_on_cran()

  p <- rfm_plot_segment(my_segments, interactive = TRUE)
  expect_equal(p$x$attrs[[1]]$type, "treemap")
  expect_equal(p$x$attrs[[1]]$values, c(50, 86, 158, 111, 278, 35, 48, 229))
  expect_equal(p$x$attrs[[1]]$labels,
               c("About To Sleep", "At Risk", "Champions", "Lost",
               "Loyal Customers", "Need Attention", "Others",
               "Potential Loyalist"))
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))
})

test_that('interactive segment scatter plot', {

  skip_on_cran()

  p <- rfm_plot_segment_scatter(segments, "monetary", "recency",
                                interactive = TRUE)


  expect_equal(p$x$attrs[[1]]$mode, "markers")
  expect_equal(p$x$attrs[[1]]$colors, "Paired")
  expect_equal(p$x$attrs[[1]]$type, "scatter")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Recency vs Monetary Value</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Monetary Value</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Recency</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Median Recency</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot sorted", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, sort = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$categoryorder, "total descending")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Median Recency</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot sorted ascending", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE,
                               interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$categoryorder, "total ascending")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Median Recency</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot flipped", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, flip = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Median Recency</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot flipped sorted", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, flip = TRUE, sort = TRUE,
                                interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Median Recency</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$categoryorder, "total ascending")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

test_that("interactive median plot flipped sorted ascending", {
  skip_on_cran()

  p <- rfm_plot_median_recency(segments, flip = TRUE, sort = TRUE,
                                ascending = TRUE, interactive = TRUE)

  expect_equal(p$x$attrs[[1]]$type, "bar")
  expect_equal(p$x$attrs[[1]]$orientation, "h")
  expect_equal(p$x$attrs[[1]]$marker$color, "blue")
  expect_equal(p$x$layoutAttrs[[1]]$title, "<b>Median Recency  by Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$xaxis$title, "<b>Median Recency</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$title, "<b>Segment</b>")
  expect_equal(p$x$layoutAttrs[[1]]$yaxis$categoryorder, "total descending")
  expect_snapshot(cat(p$x$attrs[[1]]$hovertext))

})

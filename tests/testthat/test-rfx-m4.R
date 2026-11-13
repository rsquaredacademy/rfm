test_that("interactive hover labels name the selected metrics (M4)", {
  skip_on_cran()
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5,
                  revenue = (1:5) / 10)
  seg <- rfm_segment(rfm_table_customer(x, id, orders, days, revenue, ad),
                     "All", 1, 5, 1, 5, 1, 5)
  p <- rfm_plot_median_monetary(seg, interactive = TRUE, print_plot = FALSE)
  expect_equal(p$x$attrs[[1]]$hovertext, "Segment: All \nMedian Monetary Value: 0.3")
  p <- rfm_plot_median_frequency(seg, interactive = TRUE, print_plot = FALSE)
  expect_equal(p$x$attrs[[1]]$hovertext, "Segment: All \nMedian Frequency: 3")
  p <- rfm_plot_segment_scatter(seg, x = "recency", y = "frequency",
                                interactive = TRUE, print_plot = FALSE)
  expect_equal(p$x$attrs[[1]]$hovertext[1], "Recency: 1\nFrequency: 1\nSegment: All")
  p <- rfm_plot_segment_scatter(seg, x = "frequency", y = "monetary",
                                interactive = TRUE, print_plot = FALSE)
  expect_equal(p$x$attrs[[1]]$hovertext[1],
               "Frequency: 1\nMonetary Value: 0.1\nSegment: All")
})

test_that("summary charts retain negative revenue and AOV bars (M5)", {
  skip_on_cran()
  for (values in list(c(-5, 10), c(-10, -5), c(0, 0))) {
    s <- data.frame(segment = c("A", "B"), customers = 1, orders = 1,
                    revenue = values, aov = values)
    for (metric in c("revenue", "aov")) {
      for (flip in c(FALSE, TRUE)) {
        p <- rfm_plot_segment_summary(s, metric = metric, flip = flip,
                                       print_plot = FALSE)
        built <- ggplot2::ggplot_build(p)
        expect_equal(built$data[[1]]$y, values)
        expect_equal(built$data[[1]]$ymin, pmin(values, 0))
        expect_equal(built$data[[1]]$ymax, pmax(values, 0))
        expect_true(all(is.finite(built$data[[2]]$y)))
      }
    }
  }
})


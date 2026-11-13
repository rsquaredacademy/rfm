test_that("summary and median labels retain fractional values (L1)", {
  skip_on_cran()
  s <- data.frame(segment = "A", customers = 1, orders = 2, revenue = 1, aov = .5)
  for (flip in c(FALSE, TRUE)) {
    for (metric in c("aov", "revenue", "customers", "orders")) {
      p <- rfm_plot_segment_summary(s, metric = metric, flip = flip,
                                     print_plot = FALSE)
      expected <- switch(metric, aov = "0.50", revenue = "1.00",
                         customers = "1", orders = "2")
      expect_equal(ggplot2::ggplot_build(p)$data[[2]]$label, expected)
    }
    seg <- data.frame(segment = "All", amount = c(.2, .3),
                      transaction_count = c(1, 2), recency_days = c(1, 2))
    for (fun in list(rfm_plot_median_monetary, rfm_plot_median_frequency,
                     rfm_plot_median_recency)) {
      p <- fun(seg, flip = flip, print_plot = FALSE)
      expected <- if (identical(fun, rfm_plot_median_monetary)) "0.25" else "1.50"
      expect_equal(ggplot2::ggplot_build(p)$data[[2]]$label, expected)
    }
  }
})

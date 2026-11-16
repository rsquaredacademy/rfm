test_that("deprecated scatter aliases forward labels and printing by name (M3)", {
  skip_on_cran()
  ad <- as.Date("2026-01-10")
  x <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5, revenue = 1:5)
  t <- rfm_table_customer(x, id, orders, days, revenue, ad)
  seg <- rfm_segment(t, "All", 1, 5, 1, 5, 1, 5)
  printed <- 0L
  local_mocked_bindings(print = function(x, ...) {
    printed <<- printed + 1L
    invisible(x)
  },
                        .package = "base")
  for (alias in list(rfm_rm_plot, rfm_fm_plot, rfm_rf_plot)) {
    expect_warning(p <- alias(seg, xaxis_label = "X", yaxis_label = "Y",
                              plot_title = "Title", print_plot = FALSE),
                   "rfm_plot_segment_scatter")
    expect_equal(p$labels$title, "Title")
    expect_equal(p$labels$x, "X")
    expect_equal(p$labels$y, "Y")
  }
  expect_equal(printed, 0L)
  expect_warning(p <- rfm_histograms(t, xaxis_title = "X", yaxis_title = "Y",
                                     print_plot = FALSE),
                 "Use 'rfm_plot_histogram\\(\\)' instead")
  expect_equal(p$labels$x, "X")
  expect_equal(p$labels$y, "Y")
  expect_equal(printed, 0L)
})

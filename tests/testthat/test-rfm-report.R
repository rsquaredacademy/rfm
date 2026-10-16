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

orig_requireNamespace <- base::requireNamespace

test_that("rfm_create_report aborts unconditionally when dependencies are missing", {
  # Mock missing rmarkdown in interactive session
  testthat::with_mocked_bindings(
    expect_error(
      rfm_create_report(rfm_result, segments),
      class = "rlang_error"
    ),
    requireNamespace = function(pkg, ...) {
      if (pkg == "rmarkdown") FALSE else orig_requireNamespace(pkg, ...)
    },
    interactive = function() TRUE,
    .package = "base"
  )

  # Mock missing DT in non-interactive session (verifying no silent NULL)
  testthat::with_mocked_bindings(
    expect_error(
      rfm_create_report(rfm_result, segments),
      class = "rlang_error"
    ),
    requireNamespace = function(pkg, ...) {
      if (pkg == "DT") FALSE else orig_requireNamespace(pkg, ...)
    },
    interactive = function() FALSE,
    .package = "base"
  )
})

test_that("rfm_create_report copies template without destroying package template", {
  skip_on_cran()
  skip_if_not_installed("rmarkdown")
  skip_if_not_installed("knitr")
  skip_if_not_installed("rmdformats")
  skip_if_not_installed("DT")

  temp_dir1 <- tempfile("report1_")
  temp_dir2 <- tempfile("report2_")
  dir.create(temp_dir1)
  dir.create(temp_dir2)
  on.exit(unlink(c(temp_dir1, temp_dir2), recursive = TRUE), add = TRUE)

  template_path <- system.file("template", "rfm_report.Rmd", package = "rfm")
  expect_true(file.exists(template_path))
  template_size_before <- file.info(template_path)$size

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)

  setwd(temp_dir1)
  rfm_create_report(
    rfm_table = rfm_result,
    segments = segments,
    interactive = FALSE,
    title = "Customer Segments",
    author = "Analyst",
    folder_name = "out1"
  )

  # Verify package template still exists and was not renamed/moved
  expect_true(file.exists(template_path))
  expect_equal(file.info(template_path)$size, template_size_before)

  # Second invocation in separate directory
  setwd(temp_dir2)
  rfm_create_report(
    rfm_table = rfm_result,
    segments = segments,
    interactive = FALSE,
    title = "Customer Segments",
    author = "Analyst",
    folder_name = "out2"
  )

  expect_true(file.exists(template_path))
  expect_equal(file.info(template_path)$size, template_size_before)
})

test_that("build_startup_message generates expected offline text without URLs", {
  msg <- rfm:::build_startup_message()
  expect_match(msg, "maintenance mode")
  expect_match(msg, 'install\\.packages\\("rfmkit"\\)')
  expect_false(grepl("http[s]?://", msg))
})

test_that("package startup is non-interactive and offline-safe", {
  # Mock base::interactive() with .package = "base"
  testthat::with_mocked_bindings(
    expect_message(
      rfm:::.onAttach("rfm", "rfm"),
      "maintenance mode"
    ),
    interactive = function() TRUE,
    .package = "base"
  )

  # Verify message suppression
  testthat::with_mocked_bindings(
    expect_silent(
      suppressPackageStartupMessages(rfm:::.onAttach("rfm", "rfm"))
    ),
    interactive = function() TRUE,
    .package = "base"
  )

  # Non-interactive load emits nothing
  testthat::with_mocked_bindings(
    expect_silent(rfm:::.onAttach("rfm", "rfm")),
    interactive = function() FALSE,
    .package = "base"
  )
})

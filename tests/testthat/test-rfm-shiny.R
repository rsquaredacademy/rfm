orig_requireNamespace <- base::requireNamespace

test_that("rfm_launch_app aborts cleanly without interactive prompt when dependencies are missing", {
  testthat::with_mocked_bindings(
    expect_error(
      rfm_launch_app(),
      class = "rlang_error"
    ),
    requireNamespace = function(pkg, ...) {
      if (pkg == "xplorerr") FALSE else orig_requireNamespace(pkg, ...)
    },
    interactive = function() TRUE,
    .package = "base"
  )
})

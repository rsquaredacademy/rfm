## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

should_run_benchmarks <- function(x) {
  get("requireNamespace")("cpp11test", quietly = TRUE) && asNamespace("cpp11test")$should_run_benchmarks()
}


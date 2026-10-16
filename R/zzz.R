build_startup_message <- function() {
  "rfm is now in maintenance mode: it will keep receiving fixes, and a successor package is in development."
}

.onAttach <- function(...) {
  if (!base::interactive()) {
    return(invisible())
  }

  packageStartupMessage(build_startup_message())
  invisible()
}

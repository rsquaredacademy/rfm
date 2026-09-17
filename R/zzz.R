build_startup_message <- function() {
  paste0(
    "rfm is now in maintenance mode. Active development continues in rfmkit.\n",
    "Install rfmkit: install.packages(\"rfmkit\")"
  )
}

.onAttach <- function(...) {
  if (!base::interactive()) {
    return(invisible())
  }

  packageStartupMessage(build_startup_message())
  invisible()
}

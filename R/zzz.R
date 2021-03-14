.onAttach <- function(...) {

  if (!interactive() || stats::runif(1) > 0.1) return()

  pkgs <- utils::available.packages()

  cran_version <-
    pkgs %>%
    magrittr::extract("rfm", "Version") %>%
    package_version()

  local_version <- utils::packageVersion("rfm")
  behind_cran <- cran_version > local_version

  tips <- c(
    "Learn more about rfm at https://github.com/rsquaredacademy/rfm/.",
    "Use suppressPackageStartupMessages() to eliminate package startup messages.",
    "Need help getting started with regression models? Visit: https://www.rsquaredacademy.com",
    "Check out our interactive app for quick data exploration. Visit: https://apps.rsquaredacademy.com/."
  )

  tip <- sample(tips, 1)

  if (interactive()) {
    if (behind_cran) {
      msg <- c("A new version of rfm is available with bug fixes and new features.")
      packageStartupMessage(msg, "\nWould you like to install it?")
      if (utils::menu(c("Yes", "No")) == 1) {
        utils::update.packages("rfm")
      }
    } else {
      packageStartupMessage(paste(strwrap(tip), collapse = "\n"))
    }
  }

}

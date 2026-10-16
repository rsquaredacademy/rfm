#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' rfm_launch_app()
#' }
#' @export
#'
rfm_launch_app <- function() {
  app_deps <- c("xplorerr", "shiny", "haven", "readr", "readxl", "jsonlite",
                "shinyBS", "shinycssloaders", "shinythemes", "stringr", "DT")
  check_required_packages(app_deps, context = "the interactive RFM shiny app")
  xplorerr::app_rfm_analysis()
}

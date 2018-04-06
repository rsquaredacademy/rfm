#' @importFrom shiny runApp
#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' rfm_launch_app()
#' }
#' @export
#'
rfm_launch_app <- function() {
  shiny::runApp(appDir = system.file("application", package = "rfm"))
}


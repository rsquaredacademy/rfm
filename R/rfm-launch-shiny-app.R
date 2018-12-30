#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' rfm_launch_app()
#' }
#' @export
#'
rfm_launch_app <- function() {
	rlang::abort("The shiny app has been moved to a new package, `xplorerr`. To launch the app, run the below code:\n 
	- install.packages('xplorerr')\n - xplorerr::app_rfm_analysis()")
}
 

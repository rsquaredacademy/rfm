#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' rfm_launch_app()
#' }
#' @export
#'
rfm_launch_app <- function() {

	rlang::inform("`rfm_launch_app()` has been soft-deprecated and will be removed in the next release. In future, to launch the app, run the below code:\n 
	- install.packages('xplorerr')\n - xplorerr::app_rfm_analysis()\n")

	check_suggests('haven')
	check_suggests('jsonlite')
	check_suggests('readr')
	check_suggests('readxl')
	check_suggests('shinyBS')
	check_suggests('shinycssloaders')
	check_suggests('shinythemes')
	check_suggests('stringr')
	check_suggests('DT')

	xplorerr::app_rfm_analysis()

}
 

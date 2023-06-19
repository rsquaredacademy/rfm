#' @title Launch shiny app
#' @description Launches shiny app.
#' @examples
#' \dontrun{
#' rfm_launch_app()
#' }
#' @export
#'
rfm_launch_app <- function() {

	pkg_deps <- c('haven', 'readr', 'readxl', 'jsonlite',
              'shinyBS', 'shinycssloaders', 'shinythemes',
              'stringr', 'DT')

	is_installed <- sapply(pkg_deps, try_pkg)
	to_install <- pkg_deps[is.na(is_installed)]

	if (length(to_install) > 0) {
		if (interactive()) {
			message('The following package(s) must be installed:', '\n')
			for (i in seq_len(length(to_install))) {
				cat(paste('-', to_install[i], '\n'))
			}
			message('\n', 'Would you like to install?')
			if (menu(c("Yes", "No")) == 1) {
				install.packages(to_install)
				xplorerr::app_rfm_analysis()
			} else {
				stop('Sorry! The app cannot be launched without installing the required
				     packages.', call. = FALSE)
			}
		}
	} else {
		xplorerr::app_rfm_analysis()
	}


}


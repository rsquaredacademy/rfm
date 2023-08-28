#' RFM report
#'
#' Generates a segmentation ananlysis report.
#'
#' @param rfm_table An object of class \code{rfm_table}.
#' @param segments Output from \code{rfm_segment}.
#' @param interactive If \code{TRUE}, uses \code{plotly} as the visualization
#'   engine. If \code{FALSE}, uses \code{ggplot2}.
#' @param title Title of the report.
#' @param author Author of the report.
#' @param folder_name The output directory for the report.
#' @param file_name The name of the report file.
#'
#' @examples
#' \dontrun{
#' # analysis date
#' analysis_date <- as.Date('2006-12-31')
#'
#' # generate rfm score
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' # segment names
#' segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
#'                    "Promising", "New Customers", "Can't Lose Them",
#'                    "At Risk", "Need Attention", "About To Sleep", "Lost")
#'
#' # segment intervals
#' recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
#' recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
#' frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
#' frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
#' monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
#' monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)
#'
#' # generate segments
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' rfm_create_report(rfm_result, segments, FALSE,
#' "Customer Segmentation Report")
#' }
#' 
#' @importFrom utils browseURL
#'
#' @export
#'
rfm_create_report <- function(rfm_table, segments, interactive = FALSE,
                              title = NULL, author = NULL, folder_name = NULL,
                              file_name = NULL) {

  pkg_deps <- c("cli", "DT", "rmarkdown", "knitr", "rmdformats")
  if (interactive) {
    pkg_deps <- append(pkg_deps, "plotly")
  }

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
      } else {
        stop('Sorry! The report cannot be generated without installing the
        required packages.', call. = FALSE)
      }
    }
  } else {

    if (is.null(folder_name)) {
      folder_name <- "report"
    }

    if (is.null(file_name)) {
      file_name <- "rfm_report"
    }

    file_rmd <- paste0(folder_name, "/rfm_report.Rmd")
    file_html <- paste0(file_name, ".html")

    template <- system.file("template", "rfm_report.Rmd", package = "rfm")

    cli::cli_bullets(c("i" = paste0("Checking if directory `", folder_name ,
                                    "` exists")))

    if (!dir.exists(folder_name)) {
      cli::cli_bullets(c("v" = paste0("Creating directory `", folder_name ,
                                      "`")))
      dir.create(folder_name)
    } else {
      cli::cli_bullets(c("i" = paste0("Directory `", folder_name ,
                                      "` already exists")))
    }

    cli::cli_bullets(c("i" = "Checking if report template exists"))

    if (!file.exists(file_rmd)) {
      cli::cli_bullets(c("v" = paste0("Copying report template to directory `",
                                      folder_name , "`")))
      file.rename(template, paste0(getwd(), "/", file_rmd))
    } else {
      cli::cli_bullets(c("i" = paste0("Using existing report template in
                                      directory `", folder_name , "`")))
    }

    cli::cli_bullets(c("i" = paste0("Generating `", file_html , "`")))
    rmarkdown::render(file_rmd,
           quiet = TRUE,
           output_dir = folder_name,
           output_file = file_html,
           params = list(data = rfm_table,
                         segments = segments,
                         interactive = interactive,
                         report_title = title,
                         report_author = author))
    cli::cli_bullets(c("v" = "Previewing report"))
    browseURL(paste0(folder_name, "/", file_html))
  }
}

#' @importFrom magrittr extract add
#' @importFrom stats median runif quantile reorder
bins <- function(data, value, n_bins) {

  length_out <- n_bins + 1

  data[[value]] %>%
    quantile(probs = seq(0, 1, length.out = length_out)) %>%
    unname() %>%
    extract(c(-1, -length_out)) %>%
    add(1)

}

bins_lower <- function(data, value, bins) {

  data[[value]] %>%
    min() %>%
    append(bins)

}

bins_upper <- function(data, value, bins) {

  data_max <-
    data[[value]] %>%
    max() %>%
    add(1)

  c(bins, data_max)
}


check_levels <- function(rfm_heatmap_data, column) {

  rfm_heatmap_data[[column]] %>%
    as.factor() %>%
    levels() %>%
    as.vector() %>%
    as.integer()

}

modify_rfm <- function(rfm_heatmap_data, n_bins, check_levels,
                       column = "frequency_score", other_bins = n_bins) {

  missing           <- !(seq_len(n_bins) %in% check_levels)
  missing2          <- seq_len(n_bins)[missing]
  other_column      <- setdiff(names(rfm_heatmap_data), c(column, "monetary"))[1]
  extra_data        <- data.frame(
    new_values   = rep(missing2, each = other_bins),
    other_values = rep(seq_len(other_bins), times = length(missing2)),
    monetary     = rep(0, length(missing2) * other_bins)
  )
  names(extra_data) <- c(column, other_column, "monetary")
  extra_data        <- extra_data[names(rfm_heatmap_data)]
  rbind(rfm_heatmap_data, extra_data)

}

to_title_case <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

check_required_packages <- function(pkgs, context = "this feature") {
  missing_pkgs <- pkgs[!vapply(pkgs, function(p) base::requireNamespace(p, quietly = TRUE), logical(1))]
  if (length(missing_pkgs) > 0) {
    install_cmd <- sprintf('install.packages(c("%s"))', paste(missing_pkgs, collapse = '", "'))
    if (!base::requireNamespace("cli", quietly = TRUE)) {
      stop(sprintf(
        "The following required package(s) are not installed: %s. Please install them using: %s",
        paste(missing_pkgs, collapse = ", "), install_cmd
      ), call. = FALSE)
    }
    cli::cli_abort(c(
      "x" = "The following required package(s) are not installed: {.pkg {missing_pkgs}}.",
      "i" = "To use {context}, please install them manually using:",
      " " = "  {.run {install_cmd}}"
    ))
  }
}

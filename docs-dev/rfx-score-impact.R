# From the worktree, after exporting v0.5.0 to .rfx/base:
# Rscript --vanilla docs-dev/rfx-score-impact.R before .rfx/base
# Rscript --vanilla docs-dev/rfx-score-impact.R after .
Sys.setenv(LC_ALL = "C", LANG = "C")
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 2, args[1] %in% c("before", "after"))
pkgload::load_all(args[2], quiet = TRUE)
out <- list(
  rfm_data_orders = rfm_table_order(rfm_data_orders, customer_id, order_date,
                                    revenue, as.Date("2006-12-31")),
  rfm_data_customer = rfm_table_customer(rfm_data_customer, customer_id,
                                        number_of_orders, recency_days, revenue,
                                        as.Date("2007-01-01"))
)
summary_for <- function(file) {
  lines <- readLines(file)
  start <- grep("^segment_names <-", lines)[1]
  end <- grep("^monetary_upper <-", lines)[1]
  rfm_result <- out$rfm_data_orders
  eval(parse(text = lines[start:end]))
  rfm_segment_summary(rfm_segment(
    rfm_result, segment_names, recency_lower, recency_upper,
    frequency_lower, frequency_upper, monetary_lower, monetary_upper
  ))
}
out$readme_segments <- summary_for("README.Rmd")
out$vignette_segments <- summary_for("vignettes/rfm-introduction.Rmd")
if (args[1] == "before") {
  saveRDS(out, ".rfx/comparison-baseline.rds")
  quit(status = 0)
}
old <- readRDS(".rfx/comparison-baseline.rds")
for (dataset in names(out)[1:2]) {
  a <- out[[dataset]]$rfm
  b <- old[[dataset]]$rfm
  b <- b[match(a$customer_id, b$customer_id), ]
  stopifnot(identical(a$customer_id, b$customer_id))
  metrics <- c(recency_days = "recency_score", transaction_count = "frequency_score",
               amount = "monetary_score")
  for (metric in names(metrics)) {
    cuts <- quantile(a[[metric]], (1:4) / 5, names = FALSE)
    expected <- vapply(a[[metric]], function(x) 1L + sum(x > cuts), integer(1))
    if (metric == "recency_days") expected <- 6L - expected
    stopifnot(identical(as.integer(a[[metrics[[metric]]]]), expected))
  }
  cat(dataset, "customers", nrow(a), "changed R/F/M:",
      sapply(unname(metrics), function(metric) sum(a[[metric]] != b[[metric]])), "\n")
  changed <- Reduce(`|`, lapply(unname(metrics), function(metric) a[[metric]] != b[[metric]]))
  print(as.data.frame(a[changed, c("customer_id", names(metrics), unname(metrics))]),
        row.names = FALSE)
}
for (name in c("readme_segments", "vignette_segments")) {
  cat(name, "\n")
  print(merge(old[[name]][c("segment", "customers")],
               out[[name]][c("segment", "customers")], by = "segment",
               all = TRUE, suffixes = c("_old", "_new")), row.names = FALSE)
}

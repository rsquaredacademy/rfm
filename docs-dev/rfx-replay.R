# Run from the worktree: Rscript --vanilla docs-dev/rfx-replay.R
Sys.setenv(LC_ALL = "C", LANG = "C")
pkgload::load_all(quiet = TRUE)

cat("H1 / M1 / M2: release metadata\n")
print(read.dcf("DESCRIPTION")[, c("Version", "Authors@R", "Imports")])
ad <- as.Date("2026-01-10")

cat("\nH2: transaction metadata and conserved totals\n")
orders <- data.frame(id = c("a", "a", "b"), date = ad - c(2, 1, 1),
                     revenue = c(10, 20, 40), product = c("X", "Y", "X"))
out <- rfm_table_order(orders, id, date, revenue, ad)$rfm
print(as.data.frame(out[c("customer_id", "transaction_count", "amount")]))
print(c(input_revenue = sum(orders$revenue), output_revenue = sum(out$amount),
        input_orders = nrow(orders), output_orders = sum(out$transaction_count)))
dup <- data.frame(id = c("a", "a"), orders = 1, days = 1, revenue = 10)
cat(tryCatch(rfm_table_customer(dup, id, orders, days, revenue, ad),
             error = conditionMessage), "\n")

cat("\nH3: dollars/cents (hand reference 1:5)\n")
d <- data.frame(id = letters[1:5], orders = 1:5, days = 1:5, revenue = (1:5) / 10)
score <- function(x) rfm_table_customer(x, id, orders, days, revenue, ad)
t <- score(d)
print(cbind(dollars = t$rfm$monetary_score,
            cents = score(transform(d, revenue = revenue * 100))$rfm$monetary_score,
            reference = 1:5))
cat("mtcars quintile cut points:\n")
print(rfm:::bins(mtcars, "mpg", 5))

cat("\nH4: observed NA and absent pair\n")
x <- expand.grid(days = c(0, 3, 6), orders = c(1L, 4L, 7L))
x$id <- seq_len(nrow(x))
x$revenue <- 10
x$revenue[1] <- NA_real_
heat <- function(x) as.data.frame(rfm_heatmap_data(rfm_table_customer(
  x, id, orders, days, revenue, ad,
  recency_bins = 3, frequency_bins = 3, monetary_bins = c(5, 20)
)))
h <- heat(x)
print(h[h$frequency_score == 1 & h$recency_score == 3, ])
h <- heat(x[-9, ])
print(h[(h$frequency_score == 1 & h$recency_score == 3) |
          (h$frequency_score == 3 & h$recency_score == 1), ])

cat("\nH5: numeric-looking segment name\n")
print(rfm_segment(t, "1", 1, 5, 1, 5, 1, 5)$segment)
seg <- rfm_segment(t, "All", 1, 5, 1, 5, 1, 5)

cat("\nM3: scatter and histogram wrapper labels\n")
for (alias in list(rfm_rm_plot, rfm_fm_plot, rfm_rf_plot)) {
  p <- suppressWarnings(alias(seg, xaxis_label = "X", yaxis_label = "Y",
                               plot_title = "Title", print_plot = FALSE))
  print(p$labels[c("title", "x", "y")])
}
p <- suppressWarnings(rfm_histograms(t, xaxis_title = "X", yaxis_title = "Y",
                                      print_plot = FALSE))
print(p$labels[c("x", "y")])

cat("\nM4: median and scatter hover text\n")
for (fun in list(rfm_plot_median_monetary, rfm_plot_median_frequency)) {
  print(fun(seg, interactive = TRUE, print_plot = FALSE)$x$attrs[[1]]$hovertext)
}
print(rfm_plot_segment_scatter(seg, x = "recency", y = "frequency",
                                interactive = TRUE, print_plot = FALSE)$x$attrs[[1]]$hovertext[1])

cat("\nM5: mixed and all-negative revenue/AOV\n")
for (values in list(c(-5, 10), c(-10, -5))) {
  s <- data.frame(segment = c("A", "B"), customers = 1, orders = 1,
                  revenue = values, aov = values)
  for (metric in c("revenue", "aov")) {
    p <- rfm_plot_segment_summary(s, metric = metric, print_plot = FALSE)
    print(ggplot2::ggplot_build(p)$data[[1]][c("y", "ymin", "ymax")])
  }
}

cat("\nL1: fractional AOV label\n")
s <- data.frame(segment = "A", customers = 1, orders = 2, revenue = 1, aov = .5)
p <- rfm_plot_segment_summary(s, metric = "aov", print_plot = FALSE)
print(ggplot2::ggplot_build(p)$data[[2]][c("label", "y")])
cat("\nReplay complete. Regression assertions live in tests/testthat/test-rfx-*.R.\n")

## ---- echo=FALSE, message=FALSE-----------------------------------------------
library(rfm)
library(knitr)
library(kableExtra)
library(magrittr)
library(dplyr)
library(ggplot2)
library(DT)
library(grDevices)
library(RColorBrewer)
options(knitr.table.format = "html")
options(tibble.width = Inf)

## ----rfm_data_orders----------------------------------------------------------
rfm_data_orders

## ----rfm_table_order, eval=FALSE----------------------------------------------
#  analysis_date <- lubridate::as_date("2006-12-31")
#  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#  rfm_result

## ----rfm_table_order2, eval=TRUE, echo=FALSE----------------------------------
analysis_date <- lubridate::as_date("2006-12-31")
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
rfm_result %>%
  use_series(rfm) %>%
  slice(1:10) %>%
  kable() %>%
  kable_styling()

## ----heatmap, fig.align='center', fig.width=8, fig.height=6-------------------
rfm_heatmap(rfm_result)

## ----barchart, fig.align='center', fig.width=8, fig.height=6------------------
rfm_bar_chart(rfm_result)

## ----rfmhist, fig.align='center', fig.width=8, fig.height=6-------------------
rfm_histograms(rfm_result)

## ----rfmorders, fig.align='center', fig.width=8, fig.height=6-----------------
rfm_order_dist(rfm_result)

## ----mr, fig.align='center', fig.width=7, fig.height=7------------------------
rfm_rm_plot(rfm_result)

## ----fm, fig.align='center', fig.width=7, fig.height=7------------------------
rfm_fm_plot(rfm_result)

## ----fr, fig.align='center', fig.width=7, fig.height=7------------------------
rfm_rf_plot(rfm_result)

## ----segments, echo=FALSE-----------------------------------------------------
segment <- c(
  "Champions", "Loyal Customers", "Potential Loyalist",
  "New Customers", "Promising", "Need Attention",
  "About To Sleep", "At Risk", "Can't Lose Them", "Hibernating",
  "Lost"
)
description <- c(
  "Bought recently, buy often and spend the most",
  "Spend good money. Responsive to promotions",
  "Recent customers, spent good amount, bought more than once",
  "Bought more recently, but not often",
  "Recent shoppers, but haven't spent much",
  "Above average recency, frequency & monetary values",
  "Below average recency, frequency & monetary values",
  "Spent big money, purchased often but long time ago",
  "Made big purchases and often, but long time ago",
  "Low spenders, low frequency, purchased long time ago",
  "Lowest recency, frequency & monetary scores"
)
recency <- c("4 - 5", "2 - 5", "3 - 5", "4 - 5", "3 - 4", "2 - 3", "2 - 3", "<= 2", "<= 1", "1 - 2", "<= 2")
frequency <- c("4 - 5", "3 - 5", "1 - 3", "<= 1", "<= 1", "2 - 3", "<= 2", "2 - 5", "4 - 5", "1 - 2", "<= 2")
monetary <- c("4 - 5", "3 - 5", "1 - 3", "<= 1", "<= 1", "2 - 3", "<= 2", "2 - 5", "4 - 5", "1 - 2", "<= 2")
segments <- tibble(
  Segment = segment, Description = description,
  R = recency, `F` = frequency, M = monetary
)
segments %>%
  kable() %>%
  kable_styling(full_width = TRUE, font_size = 12)

## ----criteria, echo=FALSE-----------------------------------------------------
segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
  "New Customers", "Promising", "Need Attention", "About To Sleep",
  "At Risk", "Can't Lose Them", "Lost")

recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)

segments <- rfm_segment(rfm_result, segment_names, recency_lower, recency_upper,
frequency_lower, frequency_upper, monetary_lower, monetary_upper)

# use datatable
segments %>%
  datatable(
    filter = "top",
    options = list(pageLength = 5, autoWidth = TRUE),
    colnames = c(
      "Customer", "Segment", "RFM",
      "Orders", "Recency", "Total Spend"
    )
  )

## ----rfm_customers------------------------------------------------------------
segments %>%
  count(segment) %>%
  arrange(desc(n)) %>%
  rename(Segment = segment, Count = n)

## ----avg_recency, fig.align='center', fig.height=5, fig.width=6---------------
rfm_plot_median_recency(segments)

## ----avg_frequency, fig.align='center', fig.height=5, fig.width=6-------------
rfm_plot_median_frequency(segments)

## ----avg_monetary, fig.align='center', fig.height=5, fig.width=6--------------
rfm_plot_median_monetary(segments)


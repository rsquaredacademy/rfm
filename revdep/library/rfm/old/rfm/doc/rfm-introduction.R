## ----echo=FALSE, message=FALSE------------------------------------------------
library(rfm)
library(dplyr)
library(rlang)
library(scales)
library(knitr)
library(kableExtra)
library(magrittr)
library(ggplot2)
library(DT)
library(grDevices)
library(RColorBrewer)
options(knitr.table.format = "html")

## ----rfm_data_orders----------------------------------------------------------
head(rfm_data_orders)

## ----rfm_data_customer--------------------------------------------------------
head(rfm_data_customer)

## ----rfm_table_order, eval=FALSE----------------------------------------------
#  analysis_date <- as.Date("2006-12-31")
#  rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
#  rfm_result

## ----rfm_table_order2, eval=TRUE, echo=FALSE----------------------------------
analysis_date <- as.Date("2006-12-31")
rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date, revenue, analysis_date)
rfm_result$rfm[1:10, ] %>%
  select(customer_id, recency_days, transaction_count, amount, rfm_score, recency_score, frequency_score, monetary_score, first_name, last_name, email) %>% 
  kable() %>%
  kable_styling()

## ----segments, echo=FALSE-----------------------------------------------------
segment <- c("Champions", "Potential Loyalist", "Loyal Customers", 
             "Promising", "New Customers", "Can't Lose Them", 
             "At Risk", "Need Attention", "About To Sleep", "Lost")
description <- c(
  "Bought recently, buy often and spend the most",
  "Recent customers, spent good amount, bought more than once",
  "Spend good money. Responsive to promotions",
  "Recent shoppers, but haven't spent much",
  "Bought more recently, but not often",
  "Made big purchases and often, but long time ago",
  "Spent big money, purchased often but long time ago",
  "Above average recency, frequency & monetary values",
  "Below average recency, frequency & monetary values",
  "Bought a long time ago, average amount spent"
)
recency <-   c("5", "3 - 5", "2 - 4", "3 - 4", "4 - 5", "1 - 2", "1 - 2", "1 - 3", "2 - 3", "1 - 1")
frequency <- c("5", "3 - 5", "2 - 4", "1 - 3", "1 - 3", "3 - 4", "2 - 5", "3 - 5", "1 - 3", "1 - 5")
monetary <-  c("5", "2 - 5", "2 - 4", "3 - 5", "1 - 5", "4 - 5", "4 - 5", "3 - 5", "1 - 4", "1 - 5")
segments <- data.frame(
  Segment = segment, Description = description,
  R = recency, `F` = frequency, M = monetary
)

segments %>%
  kable() %>%
  kable_styling(full_width = FALSE, font_size = 12)

## ----criteria, echo=FALSE-----------------------------------------------------
segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers", 
                   "Promising", "New Customers", "Can't Lose Them", 
                   "At Risk", "Need Attention", "About To Sleep", "Lost")

recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)
recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)
frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)
frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)
monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)
monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)

segments <- rfm_segment(rfm_result, segment_names, recency_lower, recency_upper,
frequency_lower, frequency_upper, monetary_lower, monetary_upper)

segments %>%
  head(10) %>%
  kable() %>%
  kable_styling()

## ----segment_summary----------------------------------------------------------
rfm_segment_summary(segments)

## ----segment_plot, fig.align='center', fig.width=7, fig.height=7--------------
segments %>%
  rfm_segment_summary() %>%
  rfm_plot_segment()

## ----segment_sumamry_plot, fig.align='center', fig.width=7, fig.height=7------
segments %>%
  rfm_segment_summary() %>%
  rfm_plot_segment_summary()

## ----revenue_dist_plot, fig.align='center', fig.width=7, fig.height=7---------
segments %>%
  rfm_segment_summary() %>%
  rfm_plot_revenue_dist()


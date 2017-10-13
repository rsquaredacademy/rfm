library(readr)
library(lubridate)
library(dplyr)
library(magrittr)
library(forcats)
library(purrr)
library(ggplot2)

# read data
rfm_data <- readr::read_csv('https://raw.githubusercontent.com/blast-analytics-marketing/RFM-analysis/master/sample-orders.csv')

# view data
rfm_data

# now
input_date <- as_datetime('2014-04-01 05:30:00', tz = 'UTC')

# change datetime class
rfm_data %<>%
  mutate(
    ord_time = mdy_hm(order_date)
  ) %>%
  select(ord_time, order_id, customer, grand_total) %>%
  rename(order_date = ord_time, order_id = order_id,
         customer_id = customer, revenue = grand_total)

# export data
write.csv(rfm_data, 'rfm_data.csv')

rfm_table <- rfm_data %>%
  select(customer_id, order_date, revenue) %>%
  group_by(customer_id) %>%
  summarise(date_most_recent = min(order_date), amount = sum(revenue),
            transaction_count = n()) %>%
  mutate(
    recency_days = (input_date - date_most_recent) / ddays()
  ) %>%
  select(customer_id, date_most_recent, recency_days, transaction_count,
         amount)

# monetary_score
no_of_bins <- 5
length_out <- no_of_bins + 1
bins <- rfm_table %>%
  pull(amount) %>%
  quantile(probs = seq(0, 1, length.out = length_out)) %>%
  unname() %>%
  `extract`(c(-1, -length_out)) %>%
  add(1)

bins_lower <- rfm_table %>%
  pull(amount) %>%
  min() %>%
  append(bins)

bins_upper <- rfm_table %>%
  pull(amount) %>%
  max %>%
  add(1) %>%
  prepend(bins)

rfm_table$monetary_score <- NA
for (i in seq_len(no_of_bins)) {
  rfm_table$monetary_score[rfm_table$amount >= bins_lower[i] &
                             rfm_table$amount < bins_upper[i]] <- i
}


rfm_table %>%
  group_by(monetary_score) %>%
  summarise(count = n())


# recency score
bins <- rfm_table %>%
  pull(recency_days) %>%
  quantile(probs = seq(0, 1, length.out = length_out)) %>%
  unname() %>%
  `extract`(c(-1, -length_out)) %>%
  add(1)

bins_lower <- rfm_table %>%
  pull(recency_days) %>%
  min() %>%
  append(bins)

bins_upper <- rfm_table %>%
  pull(recency_days) %>%
  max %>%
  add(1) %>%
  prepend(bins)

rfm_table$recency_score <- NA
for (i in seq_len(no_of_bins)) {
  rfm_table$recency_score[rfm_table$recency_days >= bins_lower[i] &
                             rfm_table$recency_days < bins_upper[i]] <- i
}

rfm_table %>%
  group_by(recency_score) %>%
  summarise(count = n())


# frequency_score
bins <- rfm_table %>%
  pull(transaction_count) %>%
  quantile(probs = seq(0, 1, length.out = length_out)) %>%
  unname() %>%
  `extract`(c(-1, -length_out)) %>%
  add(1)

bins_lower <- rfm_table %>%
  pull(transaction_count) %>%
  min() %>%
  append(bins)

bins_upper <- rfm_table %>%
  pull(transaction_count) %>%
  max %>%
  add(1) %>%
  prepend(bins)

rfm_table$frequency_score <- NA
for (i in seq_len(no_of_bins)) {
  rfm_table$frequency_score[rfm_table$transaction_count >= bins_lower[i] &
                            rfm_table$transaction_count < bins_upper[i]] <- i
}

rfm_table %>%
  group_by(frequency_score) %>%
  summarise(count = n())


# rfm_score
rfm_table %<>%
  mutate(
    rfm_score = recency_score * 100 + frequency_score * 10 + monetary_score
  ) %>%
  select(customer_id, date_most_recent, recency_days, transaction_count, amount,
         recency_score, frequency_score, monetary_score, rfm_score)

# heat map data
rfm_heatmap <- rfm_table %>%
  group_by(frequency_score, recency_score) %>%
  select(frequency_score, recency_score, amount) %>%
  summarise(monetary = mean(amount))

check_levels <- rfm_heatmap %>%
  pull(frequency_score) %>%
  as.factor() %>%
  fct_unique()

missing <- !(seq_len(no_of_bins) %in% check_levels )
missing2 <- seq_len(no_of_bins)[missing]
extra_data <- expand.grid(missing2, 1:5, 0)
names(extra_data) <- names(rfm_heatmap)
rfm_heatmap %<>%
  bind_rows(extra_data)

# heat map
ggplot(data = rfm_heatmap) +
  geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
  scale_fill_gradientn(limits = c(0, 300), colours = topo.colors(5, alpha = 0.5),
    breaks = c(0, 50, 100,  150, 200, 250, 300),
    name = 'Mean Monetary Value') +
  ggtitle('RFM Heat Map') + xlab('Frequency') + ylab('Recency')

# bar chart
ggplot(data = rfm_table) +
  geom_bar(aes(x = frequency_score), fill = 'blue') +
  facet_grid(recency_score ~ ., switch = 'x') +
  xlab('Frequency Score') + ylab('Record Count')

# scatter plots
# monetary vs recency
ggplot(rfm_table) +
  geom_point(aes(x = amount, y = recency_days),
             color = 'blue') +
  xlab('Monetary') + ylab('Recency')

# monetary vs frequency
ggplot(rfm_table) +
  geom_point(aes(x = amount, y = transaction_count),
    color = 'blue') +
  xlab('Monetary') + ylab('Frequency')

# frequency vs recency
ggplot(rfm_table) +
  geom_point(aes(x = transaction_count, y = recency_days),
             color = 'blue') +
  xlab('Frequency') + ylab('Recency')

# test
output <- read_csv('rfm_spss_output.csv')
output %>%
  group_by(Monetary_score) %>%
  summarise(count = n())
output %>%
  group_by(Recency_score) %>%
  summarise(count = n())
output %>%
  group_by(Frequency_score) %>%
  summarise(count = n())

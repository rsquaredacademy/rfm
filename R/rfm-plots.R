#' @importFrom magrittr extract2
#' @importFrom ggplot2 ggplot geom_tile aes scale_fill_gradientn ggtitle xlab
#' ylab theme element_text scale_y_continuous sec_axis element_blank
#' @importFrom grDevices topo.colors
#' @title RFM Heatmap
#' @description Heatmap of Mean Monetary Value
#' @param data a data.frame or a tibble
#' @return Heatmap
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # heat map
#' rfm_heatmap(rfm_result)
#'
#' @export
#'
rfm_heatmap <- function(data) {
  mapdata <- heatmap_data(rfm_table = data)

  ulm <- mapdata %>%
    extract2("monetary") %>%
    max() %>%
    ceiling()

  llm <- mapdata %>%
    extract2("monetary") %>%
    min() %>%
    floor()

  guide_breaks <- seq(llm, ulm, length.out = 6) %>%
    round()

  p <- ggplot(data = mapdata) +
    geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
    scale_fill_gradientn(
      limits = c(llm, ulm), colours = topo.colors(9, alpha = 0.5),
      breaks = guide_breaks,
      name = "Mean Monetary Value"
    ) +
    ggtitle("RFM Heat Map") + xlab("Frequency") + ylab("Recency") +
    theme(
      plot.title = element_text(hjust = 0.5)
    )

  print(p)
}

#' @importFrom tidyr gather
#' @importFrom ggplot2 geom_histogram labeller
#' @title RFM Histograms
#' @description Histograms of recency, frequency and monetary value
#' @param rfm_table an object of class \code{rfm_table}
#' @return Histograms
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # histograms
#' rfm_histograms(rfm_result)
#'
#' @export
#'
rfm_histograms <- function(rfm_table) {
  rfm_table %>%
    use_series(rfm) %>%
    select(recency_days, transaction_count, amount) %>%
    gather(rfm, score) %>%
    ggplot(aes(score)) +
    geom_histogram(bins = 9, fill = "blue") +
    ylab("Count") + ggtitle("RFM Histograms") + xlab(" ") +
    facet_grid(
      . ~ rfm, scales = "free_x",
      labeller = labeller(
        rfm = c(
          amount = "Monetary", recency_days = "Recency",
          transaction_count = "Frequency"
        )
      )
    ) +
    theme(
      plot.title = element_text(hjust = 0.5)
    )
}



#' @importFrom ggplot2 geom_bar facet_grid
#' @title RFM Bar Chart
#' @description Bar Chart of Frequency Score vs Recency Score
#' @param rfm_table an object of class \code{rfm_table}
#' @return Bar Chart
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # bar chart
#' rfm_bar_chart(rfm_result)
#'
#' @export
#'
rfm_bar_chart <- function(rfm_table) {
  data <- rfm_table %>%
    use_series(rfm)

  data$recency_score <- factor(data$recency_score, levels = c(5, 4, 3, 2, 1))

  p <- ggplot(data = data) +
    geom_bar(aes(x = monetary_score), fill = "blue") +
    facet_grid(recency_score ~ frequency_score) +
    scale_y_continuous(sec.axis = sec_axis(~ ., name = "Recency Score")) +
    xlab("Monetary Score") + ylab(" ") + ggtitle("Frequency Score") +
    theme(
      plot.title = element_text(
        face = "plain", size = 11, hjust = 0.5
      ),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank()
    )

  print(p)
}


#' @importFrom dplyr count
#' @importFrom magrittr multiply_by
#' @importFrom ggplot2 ylim geom_text position_dodge
#' @title Customers by Orders
#' @description Number of customers by number of orders
#' @param rfm_table an object of class \code{rfm_table}
#' @return Bar Chart
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # bar chart
#' rfm_order_dist(rfm_result)
#'
#' @export
#'
rfm_order_dist <- function(rfm_table) {
  data <- rfm_result %>%
    use_series(rfm) %>%
    count(transaction_count)

  ylim_max <- data %>%
    pull(n) %>%
    max() %>%
    multiply_by(1.1) %>%
    ceiling()

  data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = "blue") +
    xlab("Orders") + ylab("Customers") + ylim(0, ylim_max) +
    ggtitle("Customers by Orders") +
    geom_text(
      aes(label = n, y = n + 3), position = position_dodge(0.9), vjust = 0
    ) +
    theme(
      plot.title = element_text(hjust = 0.5)
    )
}

#' @importFrom ggplot2 geom_point
#' @title RFM Scatter Plot
#' @description Monetary Value vs Recency, Frequency vs Monetary Value and Frequency vs Recency Plots
#' @param rfm_table an object of class \code{rfm_table}
#' @return Scatter Plot
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_date('2006-12-31', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # monetary value vs recency
#' rfm_rm_plot(rfm_result)
#'
#' # frequency vs monetary value
#' rfm_fm_plot(rfm_result)
#'
#' # frequency vs recency
#' rfm_rf_plot(rfm_result)
#'
#' @export
#'
rfm_rm_plot <- function(rfm_table) {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = amount, y = recency_days),
      color = "blue"
    ) +
    xlab("Monetary") + ylab("Recency") +
    ggtitle("Recency vs Monetary")

  print(p)
}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_fm_plot <- function(rfm_table) {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = amount, y = transaction_count),
      color = "blue"
    ) +
    xlab("Monetary") + ylab("Frequency") +
    ggtitle("Frequency vs Monetary")

  print(p)
}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_rf_plot <- function(rfm_table) {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = transaction_count, y = recency_days),
      color = "blue"
    ) +
    xlab("Frequency") + ylab("Recency") +
    ggtitle("Recency vs Frequency")

  print(p)
}

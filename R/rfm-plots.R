#' @importFrom magrittr extract2
#' @importFrom ggplot2 ggplot geom_tile aes scale_fill_gradientn ggtitle xlab
#' ylab theme element_text scale_y_continuous sec_axis element_blank
#' @importFrom RColorBrewer brewer.pal
#' @importFrom grDevices topo.colors
#' @title RFM Heatmap
#' @description The heat map shows the average monetary value for different
#' categories of recency and frequency scores. Higher scores of frequency and
#' recency are characterized by higher average monetary value as indicated by
#' the darker areas in the heatmap.
#' @param data an object of class \code{rfm_table}
#' @param plot_title title of the plot
#' @param plot_title_justify horizontal justification of the plot title;
#' 0 for left justified and 1 for right justified
#' @param xaxis_title x axis title
#' @param yaxis_title y axis title
#' @param legend_title legend title
#' @param brewer_n indicates the number of colors in the palette; RColorBrewer is
#' used for the color palette of the heatmap; check the documentation of
#' \code{brewer.pal}
#' @param brewer_name palette name; heck the documentation of \code{brewer.pal}
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
rfm_heatmap <- function(data, plot_title = "RFM Heat Map",
                        plot_title_justify = 0.5, xaxis_title = "Frequency",
                        yaxis_title = "Recency",
                        legend_title = "Mean Monetary Value",
                        brewer_n = 5, brewer_name = "PuBu") {
  mapdata <- heatmap_data(rfm_table = data)

  ulm <- mapdata %>%
    extract2("monetary") %>%
    max() %>%
    ceiling()

  llm <- mapdata %>%
    extract2("monetary") %>%
    min() %>%
    floor()

  bins <- mapdata %>%
    use_series(frequency_score) %>%
    max

  guide_breaks <- seq(llm, ulm, length.out = bins) %>%
    round()

  p <- ggplot(data = mapdata) +
    geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
    scale_fill_gradientn(
      limits = c(llm, ulm), colours = brewer.pal(n = brewer_n,
                                                 name = brewer_name),
      # breaks = guide_breaks,
      name = legend_title
    ) +
    ggtitle(plot_title) + xlab(xaxis_title) + ylab(yaxis_title) +
    theme(
      plot.title = element_text(hjust = plot_title_justify)
    )

  print(p)
}

#' @importFrom tidyr gather
#' @importFrom ggplot2 geom_histogram labeller
#' @title RFM Histograms
#' @description Histograms of recency, frequency and monetary value
#' @param rfm_table an object of class \code{rfm_table}
#' @param hist_bins number of bins of the histograms
#' @param hist_color color of the histogram
#' @param plot_title title of the plot
#' @param xaxis_title x axis title
#' @param yaxis_title y axis title
#' @param hist_m_label label of the monetary value histogram
#' @param hist_r_label label of the recency histogram
#' @param hist_f_label label of the frequency histogram
#' @param plot_title_justify horizontal justification of the plot title;
#' 0 for left justified and 1 for right justified
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
rfm_histograms <- function(rfm_table, hist_bins = 9, hist_color = 'blue',
                           plot_title = 'RFM Histograms', xaxis_title = ' ',
                           yaxis_title = 'Count', hist_m_label = 'Monetary',
                           hist_r_label = 'Recency', hist_f_label = 'Frequency',
                           plot_title_justify = 0.5) {
  rfm_table %>%
    use_series(rfm) %>%
    select(recency_days, transaction_count, amount) %>%
    gather(rfm, score) %>%
    ggplot(aes(score)) +
    geom_histogram(bins = hist_bins, fill = hist_color) +
    ylab(yaxis_title) + ggtitle(plot_title) + xlab(xaxis_title) +
    facet_grid(
      . ~ rfm, scales = "free_x",
      labeller = labeller(
        rfm = c(
          amount = hist_m_label, recency_days = hist_r_label,
          transaction_count = hist_f_label
        )
      )
    ) +
    theme(
      plot.title = element_text(hjust = plot_title_justify)
    )
}



#' @importFrom ggplot2 geom_bar facet_grid
#' @title RFM Bar Chart
#' @description Examine the distribution of monetary scores for the different
#' combinations of frequency and recency scores.
#' @param rfm_table an object of class \code{rfm_table}
#' @param bar_color color of the bars
#' @param xaxis_title x axis title
#' @param yaxis_title y axis title
#' @param sec_xaxis_title secondary x axis title
#' @param sec_yaxis_title secondary y axis title
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
rfm_bar_chart <- function(rfm_table, bar_color = 'blue',
                          xaxis_title = 'Monetary Score',
                          sec_xaxis_title = 'Frequency Score',
                          yaxis_title = ' ',
                          sec_yaxis_title = 'Recency Score') {

  data <- rfm_table %>%
    use_series(rfm)

  rlevels <- rfm_table %>%
    use_series(recency_bins) %>%
    seq_len() %>%
    rev()

  data$recency_score <- factor(data$recency_score, levels = rlevels)

  p <- ggplot(data = data) +
    geom_bar(aes(x = monetary_score), fill = bar_color) +
    facet_grid(recency_score ~ frequency_score) +
    scale_y_continuous(sec.axis = sec_axis(~ ., name = sec_yaxis_title)) +
    xlab(xaxis_title) + ylab(" ") + ggtitle(sec_xaxis_title) +
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
#' @description Visualize the distribution of customers across orders
#' @param rfm_table an object of class \code{rfm_table}
#' @param bar_color color of the bars
#' @param xaxis_title x axis title
#' @param yaxis_title y axis title
#' @param plot_title title of the plot
#' @param plot_title_justify horizontal justification of the plot title;
#' 0 for left justified and 1 for right justified
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
rfm_order_dist <- function(rfm_table, bar_color = 'blue',
                           xaxis_title = 'Orders', yaxis_title = 'Customers',
                           plot_title = 'Customers by Orders',
                           plot_title_justify = 0.5) {
  data <- rfm_table %>%
    use_series(rfm) %>%
    count(transaction_count)

  ylim_max <- data %>%
    pull(n) %>%
    max() %>%
    multiply_by(1.1) %>%
    ceiling()

  data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = bar_color) +
    xlab(xaxis_title) + ylab(yaxis_title) + ylim(0, ylim_max) +
    ggtitle(plot_title) +
    geom_text(
      aes(label = n, y = n + 3), position = position_dodge(0.9), vjust = 0
    ) +
    theme(
      plot.title = element_text(hjust = 0.5)
    )
}

#' @importFrom ggplot2 geom_point
#' @title RFM Scatter Plot
#' @description Examine the relationship between the above recency, frequency and monetary values
#' @param rfm_table an object of class \code{rfm_table}
#' @param point_color color of the scatter points
#' @param xaxis_title x axis title
#' @param yaxis_title y axis title
#' @param plot_title title of the plot
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
rfm_rm_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Monetary', yaxis_title = 'Recency',
                        plot_title = 'Recency vs Monetary') {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = amount, y = recency_days),
      color = point_color
    ) +
    xlab(xaxis_title) + ylab(yaxis_title) +
    ggtitle(plot_title)

  print(p)
}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_fm_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Monetary', yaxis_title = 'Frequency',
                        plot_title = 'Frequency vs Monetary') {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = amount, y = transaction_count),
      color = point_color
    ) +
    xlab(xaxis_title) + ylab(yaxis_title) +
    ggtitle(plot_title)

  print(p)
}

#' @rdname rfm_rm_plot
#' @export
#'
rfm_rf_plot <- function(rfm_table, point_color = 'blue',
                        xaxis_title = 'Frequency', yaxis_title = 'Recency',
                        plot_title = 'Recency vs Frequency') {
  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(
      aes(x = transaction_count, y = recency_days),
      color = point_color
    ) +
    xlab(xaxis_title) + ylab(yaxis_title) +
    ggtitle(plot_title)

  print(p)
}

#' @importFrom magrittr extract2
#' @importFrom ggplot2 ggplot geom_tile aes scale_fill_gradientn ggtitle xlab ylab 
#' @importFrom grDevices topo.colors
#' @title RFM Heatmap
#' @description Heatmap of Mean Monetary Value
#' @param data a data.frame or a tibble
#' @return Heatmap
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
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
    extract2('monetary') %>%
    max %>%
    ceiling()

  llm <- mapdata %>%
    extract2('monetary') %>%
    min %>%
    floor()

  guide_breaks <- seq(llm, ulm, length.out = 6) %>%
    round()

  p <- ggplot(data = mapdata) +
   geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
   scale_fill_gradientn(limits = c(llm, ulm), colours = topo.colors(9, alpha = 0.5),
                        breaks = guide_breaks,
                        name = 'Mean Monetary Value') +
   ggtitle('RFM Heat Map') + xlab('Frequency') + ylab('Recency')

 print(p)

}


#' @importFrom ggplot2 geom_bar facet_grid
#' @title RFM Bar Chart
#' @description Bar Chart of Frequency Score vs Recency Score
#' @param rfm_table an object of class \code{rfm_table}
#' @return Bar Chart
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
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

  p <- ggplot(data = data) +
    geom_bar(aes(x = frequency_score), fill = 'blue') +
    facet_grid(recency_score ~ ., switch = 'x') +
    xlab('Frequency Score') + ylab('Record Count') 

  print(p)

}

#' @importFrom ggplot2 geom_point
#' @title RFM Scatter Plot
#' @description Monetary Value vs Recency, Frequency vs Monetary Value and Frequency vs Recency Plots
#' @param rfm_table an object of class \code{rfm_table}
#' @return Scatter Plot
#' @examples
#' # rfm table
#' analysis_date <- lubridate::as_datetime('2014-04-01 05:30:00', tz = 'UTC')
#' rfm_result <- rfm_table(rfm_data, customer_id, order_date, revenue, analysis_date)
#'
#' # monetary value vs recency
#' rfm_mr_plot(rfm_result)
#'
#' # frequency vs monetary value
#' rfm_fm_plot(rfm_result)
#'
#' # frequency vs recency
#' rfm_fr_plot(rfm_result)
#'
#' @export
#'
rfm_mr_plot <- function(rfm_table) {

  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(aes(x = amount, y = recency_days),
               color = 'blue') +
    xlab('Monetary') + ylab('Recency')

  print(p)

}

#' @rdname rfm_mr_plot
#' @export
#'
rfm_fm_plot <- function(rfm_table) {

  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(aes(x = amount, y = transaction_count),
               color = 'blue') +
    xlab('Monetary') + ylab('Frequency')

  print(p)

}

#' @rdname rfm_mr_plot
#' @export
#'
rfm_fr_plot <- function(rfm_table) {

  data <- rfm_table %>%
    use_series(rfm)

  p <- ggplot(data) +
    geom_point(aes(x = transaction_count, y = recency_days),
               color = 'blue') +
    xlab('Frequency') + ylab('Recency')

  print(p)
}

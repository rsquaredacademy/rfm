#' Segmentation
#'
#' Create segments based on recency, frequency and monetary scores.
#'
#' @param data An object of class \code{rfm_table}.
#' @param segment_names Names of the segments.
#' @param recency_lower Lower boundary for recency score.
#' @param recency_upper Upper boundary for recency score.
#' @param frequency_lower Lower boundary for frequency score.
#' @param frequency_upper Upper boundary for frequency score.
#' @param monetary_lower Lower boundary for monetary score.
#' @param monetary_upper Upper boundary for monetary score.
#'
#' @examples
#' analysis_date <- as.Date('2006-12-31')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' rfm_segment(rfm_result, segment_names, recency_lower, recency_upper,
#' frequency_lower, frequency_upper, monetary_lower, monetary_upper)
#'
#'@export
#'
rfm_segment <- function(data, segment_names = NULL, recency_lower = NULL,
                        recency_upper = NULL, frequency_lower = NULL,
                        frequency_upper = NULL, monetary_lower = NULL,
                        monetary_upper = NULL) {

  customer_id <- NULL
  segment <- NULL

  rfm_score_table <-
    data %>%
    use_series(rfm) %>%
    dplyr::mutate(segment = 1)

  n_segments <- length(segment_names)

  for (i in seq_len(n_segments)) {
    rfm_score_table$segment[(
      (rfm_score_table$recency_score %>% dplyr::between(recency_lower[i], recency_upper[i])) &
        (rfm_score_table$frequency_score %>% dplyr::between(frequency_lower[i], frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% dplyr::between(monetary_lower[i], monetary_upper[i])) &
        !rfm_score_table$segment %in% segment_names)] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"
  rfm_score_table$segment[rfm_score_table$segment == 1]   <- "Others"

  rfm_score_table %>%
    dplyr::select(customer_id, segment, rfm_score, transaction_count, recency_days,
           amount, recency_score, frequency_score,
           monetary_score)


}

#' Segment summary
#' 
#' An overview of customer segments.
#' 
#' @param segments Output from \code{rfm_segment}.
#' 
#' @examples 
#' analysis_date <- as.Date('2006-12-31')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#' 
#' rfm_segment_summary(segments)
#' 
#' @export 
#' 
rfm_segment_summary <- function(segments) {
  segments %>% 
    dplyr::group_by(segment) %>% 
    dplyr::summarise(
      customers = dplyr::n(),
      orders = sum(transaction_count),
      revenue = sum(amount),
      aov = revenue / orders
    )
}

#' Visulaize segment summary
#' 
#' Generates plots for customers, orders, revenue and average order value for each segment.
#' 
#' @param x An object of class \code{rfm_segment_summary}.
#' @param metric Metrics to be visualized.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object. 
#' 
#' analysis_date <- as.Date('2006-12-31')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#' 
#' segment_overview <- rfm_segment_summary(segments)
#' rfm_plot_segment_summary(segment_overview)
#' rfm_plot_segment_summary(segment_overview, sort = TRUE, ascending = TRUE)
#' rfm_plot_segment_summary(segment_overview, sort = TRUE)
#'
#' @export
#' 
rfm_plot_segment_summary <- function(x, metric = NULL, sort = FALSE, ascending = FALSE, print_plot = TRUE) {

  if (is.null(metric)) {
    vars <- colnames(x)
    n_plots <- length(vars)
    plots <- list()
    for (i in 2:n_plots) {
      j <- i - 1
      var <- vars[i]
      data <- dplyr::select(x, segment, !!sym(var))
      if (sort) {
        if (ascending) {
          p <- ggplot(data, aes(x = stats::reorder(segment, !!sym(var), sum), y = !!sym(var)))   
        } else {
          p <- ggplot(data, aes(x = stats::reorder(segment, -!!sym(var), sum), y = !!sym(var)))
        }
      } else {
        p <- ggplot(data, aes(x = segment, y = !!sym(var)))
      }
      plots[[j]] <- 
        p +
          geom_bar(stat = "identity", fill = "blue") +
          ggtitle(paste(vars[i], "by segment")) +
          xlab("Segment") +
          ylab(vars[i])
    }
  }

  names(plots) <- c("customers", "orders", "revenue", "aov")

  if (print_plot) {
    gridExtra::marrangeGrob(plots, nrow = 2, ncol = 2, top = "Segments Overview")
  } else {
    return(plots)
  }
  
}

#' Revenue distribution
#' 
#' Customer and revenue distribution by segments.
#' 
#' @param x An object of class \code{rfm_segment_summary}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object. 
#' 
#' analysis_date <- as.Date('2006-12-31')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#' 
#' segment_overview <- rfm_segment_summary(segments)
#' rfm_plot_revenue_dist(segment_overview)
#' 
#' @export 
#' 
rfm_plot_revenue_dist <- function(x, print_plot = TRUE) {

  data <- rfm_prep_revenue_dist(x)

  p <- 
    ggplot(data, aes(fill=category, y=share, x=segment)) + 
    geom_bar(position="dodge", stat="identity") 

  p <- 
    p +  
    scale_fill_manual(values = c("#3b5bdb", "#91a7ff"),
                      labels = c("Share of revenue", "Share of customers")) +
    scale_y_continuous(labels = scales::percent) 

  p <- 
    p +
    theme(legend.title = element_blank(),
          legend.position = "bottom",
          panel.background = element_rect(fill = NA),
          axis.ticks = element_line(color = NA),
          panel.grid.major.y = element_line(colour = "#ced4da")) 

  p <- 
    p +
    xlab("") + 
    ylab("") +
    ggtitle("Revenue vs Number of Customers")

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

rfm_prep_revenue_dist <- function(x) {

  data <- 
    x %>% 
    dplyr::mutate(customer_share = customers / sum(customers),
                  revenue_share = revenue / sum(revenue)) %>% 
    dplyr::select(segment, customer_share, revenue_share) %>%
    tidyr::pivot_longer(!segment, names_to = "category", values_to = "share") 

  data$category <- factor(data$category, levels = c("revenue_share", "customer_share"))
  return(data)
}

#' Segmentation plots
#'
#' Segment wise median recency, frequency & monetary value plot.
#'
#' @param rfm_segment_table Output from \code{rfm_segment}.
#' @param print_plot logical; if \code{TRUE}, prints the plot else returns a plot object.
#'
#' @examples
#' analysis_date <- as.Date('2006-12-31')
#' rfm_result <- rfm_table_order(rfm_data_orders, customer_id, order_date,
#' revenue, analysis_date)
#'
#' segment_names <- c("Champions", "Loyal Customers", "Potential Loyalist",
#'   "New Customers", "Promising", "Need Attention", "About To Sleep",
#'   "At Risk", "Can't Lose Them", "Lost")
#'
#' recency_lower <- c(4, 2, 3, 4, 3, 2, 2, 1, 1, 1)
#' recency_upper <- c(5, 5, 5, 5, 4, 3, 3, 2, 1, 2)
#' frequency_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' frequency_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#' monetary_lower <- c(4, 3, 1, 1, 1, 2, 1, 2, 4, 1)
#' monetary_upper <- c(5, 5, 3, 1, 1, 3, 2, 5, 5, 2)
#'
#' segments <- rfm_segment(rfm_result, segment_names, recency_lower,
#' recency_upper, frequency_lower, frequency_upper, monetary_lower,
#' monetary_upper)
#'
#' rfm_plot_median_recency(segments)
#' rfm_plot_median_frequency(segments)
#' rfm_plot_median_monetary(segments)
#'
#' @export
#'
rfm_plot_median_recency <- function(rfm_segment_table, print_plot = TRUE) {

  # segment <- NULL
  # avg_recency <- NULL

  # data <-
  #   rfm_segment_table %>%
  #   dplyr::group_by(segment) %>%
  #   dplyr::select(segment, recency_days) %>%
  #   dplyr::summarise(avg_recency = stats::median(recency_days)) %>%
  #   dplyr::arrange(avg_recency)

  # n_fill <- nrow(data)

  # p <-
  #   ggplot(data, aes(segment, avg_recency)) +
  #   geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
  #   xlab("Segment") + ylab("Median Recency") +
  #   ggtitle("Median Recency by Segment") +
  #   coord_flip() +
  #   theme(
  #     plot.title = element_text(hjust = 0.5)
  #   )

  data <- rfm_prep_median(rfm_segment_table, recency_days)
  plot <- rfm_plot_median(data)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_frequency <- function(rfm_segment_table, print_plot = TRUE) {

  # segment <- NULL
  # avg_frequency <- NULL

  # data <-
  #   rfm_segment_table %>%
  #   dplyr::group_by(segment) %>%
  #   dplyr::select(segment, transaction_count) %>%
  #   dplyr::summarise(avg_frequency = stats::median(transaction_count)) %>%
  #   dplyr::arrange(avg_frequency)

  # n_fill <- nrow(data)

  # p <-
  #   ggplot(data, aes(segment, avg_frequency)) +
  #   geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
  #   xlab("Segment") + ylab("Median Frequency") +
  #   ggtitle("Median Frequency by Segment") +
  #   coord_flip() +
  #   theme(
  #     plot.title = element_text(hjust = 0.5)
  #   )

  data <- rfm_prep_median(rfm_segment_table, transaction_count)
  plot <- rfm_plot_median(data)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}


#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_monetary <- function(rfm_segment_table, print_plot = TRUE) {

  # segment <- NULL
  # avg_monetary <- NULL

  # data <-
  #   rfm_segment_table %>%
  #   dplyr::group_by(segment) %>%
  #   dplyr::select(segment, amount) %>%
  #   dplyr::summarise(avg_monetary = stats::median(amount)) %>%
  #   # dplyr::rename(segment = segment, avg_monetary = `median(amount)`) %>%
  #   dplyr::arrange(avg_monetary)

  # n_fill <- nrow(data)

  # p <-
  #   ggplot(data, aes(segment, avg_monetary)) +
  #   geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
  #   xlab("Segment") + ylab("Median Monetary Value") +
  #   ggtitle("Median Monetary Value by Segment") +
  #   coord_flip() +
  #   theme(
  #     plot.title = element_text(hjust = 0.5)
  #   )

  # if (print_plot) {
  #   print(p)
  # } else {
  #   return(p)
  # }

  data <- rfm_prep_median(rfm_segment_table, amount)
  plot <- rfm_plot_median(data)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

rfm_prep_median <- function(rfm_segment_table, metric) {
  
  met <- rlang::enquo(metric)
  
  result <- 
    rfm_segment_table %>%
    dplyr::group_by(segment) %>%
    dplyr::select(segment, !!met) %>%
    dplyr::summarise(mem = stats::median(!!met)) %>%
    dplyr::arrange(mem)
  
  colnames(result) <- c("segment", as_label(met))
  return(result)
  
}

rfm_plot_median <- function(data) {
  
  n_fill <- nrow(data)
  cnames <- names(data)
  y_lab  <- 
    switch(cnames[2],
           recency_days = "Median Recency",
           transaction_count = "Median Frequency",
           amount = "Median Monetary Value") 
  
  ggplot(data, aes_string(x = cnames[1], y = cnames[2])) +
    geom_bar(stat = "identity", fill = ggthemes::calc_pal()(n_fill)) +
    xlab("Segment") + 
    ylab(y_lab) +
    ggtitle(paste(y_lab, "by Segment")) +
    coord_flip() +
    theme(
      plot.title = element_text(hjust = 0.5)
    )
}

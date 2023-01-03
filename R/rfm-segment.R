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

  rfm_score_table <- data$rfm
  rfm_score_table$segment <- 1

  n_segments <- length(segment_names)

  for (i in seq_len(n_segments)) {
    rfm_score_table$segment[(
      (rfm_score_table$recency_score %>% between(recency_lower[i], recency_upper[i])) &
        (rfm_score_table$frequency_score %>% between(frequency_lower[i], frequency_upper[i])) &
        (rfm_score_table$monetary_score %>% between(monetary_lower[i], monetary_upper[i])) &
        !rfm_score_table$segment %in% segment_names)] <- segment_names[i]
  }

  rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"
  rfm_score_table$segment[rfm_score_table$segment == 1]   <- "Others"

  rfm_score_table[c("customer_id", "segment", "rfm_score", "transaction_count", "recency_days",
                    "amount", "recency_score", "frequency_score", "monetary_score")]


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

  result <-
    segments %>%
    data.table() %>%
    .[, .(customers = .N,
          orders = sum(transaction_count),
          revenue = sum(amount)),
      by = segment] %>%
    setDF()

  result$aov <- result$revenue / result$orders
  return(result)

}

#' Visulaize segment summary
#'
#' Generates plots for customers, orders, revenue and average order value for each segment.
#'
#' @param x An object of class \code{rfm_segment_summary}.
#' @param metric Metrics to be visualized.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
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
#' segment_overview <- rfm_segment_summary(segments)
#' rfm_plot_segment_summary(segment_overview)
#' rfm_plot_segment_summary(segment_overview, metric = c("customers", "orders"))
#' rfm_plot_segment_summary(segment_overview, sort = TRUE, ascending = TRUE)
#' rfm_plot_segment_summary(segment_overview, sort = TRUE)
#' rfm_plot_segment_summary(segment_overview, flip = TRUE)
#'
#' @export
#'
rfm_plot_segment_summary <- function(x, metric = NULL, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  if (is.null(metric)) {
    x <- x
  } else {
    x <- x[c("segment", metric)]
  }

  vars <- colnames(x)
  n_plots <- length(vars)
  plots <- list()
  for (i in 2:n_plots) {
    j <- i - 1
    var <- vars[i]
    data <- x[c("segment", var)]
    if (sort) {
      if (ascending) {
        if (flip) {
          p <- ggplot(data, aes_string(x = paste0("reorder(segment, -", var, ", sum)"), y = var))
        } else {
          p <- ggplot(data, aes_string(x = paste0("reorder(segment, ", var, ", sum)"), y = var))
        }
      } else {
        if (flip) {
          p <- ggplot(data, aes_string(x = paste0("reorder(segment, ", var, ", sum)"), y = var))
        } else {
          p <- ggplot(data, aes_string(x = paste0("reorder(segment, -", var, ", sum)"), y = var))
        }
      }
    } else {
      p <- ggplot(data, aes_string(x = "segment", y = var))
    }

    p <-
      p +
      geom_bar(stat = "identity", fill = "blue") +
      ggtitle(paste(vars[i], "by segment"))

    if (flip) {
      p <-
        p +
        coord_flip() +
        xlab(vars[i]) +
        ylab("Segment") +
        theme(axis.text.y = element_text(size = 7))
    } else {
      p <-
        p +
        xlab("Segment") +
        ylab(vars[i]) +
        theme(axis.text.x = element_text(size = 7))
    }

    plots[[j]] <- p

  }

  if (is.null(metric)) {
    names(plots) <- c("customers", "orders", "revenue", "aov")
  } else {
    names(plots) <- metric
  }
  
  if (print_plot) {
    if (length(plots) == 1) {
      print(plots)
    } else if (length(plots) == 2) {
      gridExtra::marrangeGrob(plots, nrow = 1, ncol = 2, top = "Segments Overview")
    } else {
      gridExtra::marrangeGrob(plots, nrow = 2, ncol = 2, top = "Segments Overview")
    }
  } else {
    return(plots)
  }

}

#' Revenue distribution
#'
#' Customer and revenue distribution by segments.
#'
#' @param x An object of class \code{rfm_segment_summary}.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
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
#' segment_overview <- rfm_segment_summary(segments)
#' rfm_plot_revenue_dist(segment_overview)
#'
#' @export
#'
rfm_plot_revenue_dist <- function(x, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_revenue_dist(x)

  p <-
    ggplot(data, aes(fill = category, y = share, x = segment)) +
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
          axis.ticks = element_line(color = NA))

  if (flip) {
    p <-
      p +
      theme(panel.grid.major.x = element_line(colour = "#ced4da")) +
      coord_flip()
  } else {
    p <-
      p +
      theme(panel.grid.major.y = element_line(colour = "#ced4da"))
  }

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

  x$customer_share <- x$customers / sum(x$customers)
  x$revenue_share <- x$revenue / sum(x$revenue)
  data <- x[c("segment", "customer_share", "revenue_share")]

  n_row    <- nrow(data)
  segment  <- rep(data$segment, each = 2)
  category <- rep(c("customer_share", "revenue_share"), times = n_row)

  share <- c()
  for (i in seq_len(n_row)) {
    y <- as.numeric(data[i, c(2, 3)])
    share <- c(share, y)
  }

  result <- data.frame(segment, category, share)
  result$category <- factor(result$category, levels = c("revenue_share", "customer_share"))
  return(result)
}

#' Segmentation plots
#'
#' Segment wise median recency, frequency & monetary value plot.
#'
#' @param rfm_segment_table Output from \code{rfm_segment}.
#' @param color Color of the bars.
#' @param sort logical; if \code{TRUE}, sort metrics.
#' @param ascending logical; if \code{TRUE}, sort metrics in ascending order.
#' @param flip logical; if \code{TRUE}, creates horizontal bar plot.
#' @param font_size Font size for X axis text.
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
#' rfm_plot_median_recency(segments, sort = TRUE, ascending = TRUE)
#' rfm_plot_median_recency(segments, sort = TRUE)
#' rfm_plot_median_recency(segments, flip = TRUE)
#' rfm_plot_median_frequency(segments)
#' rfm_plot_median_monetary(segments)
#'
#' @export
#'
rfm_plot_median_recency <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, recency_days)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_frequency <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, transaction_count)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}


#' @rdname rfm_plot_median_recency
#' @export
#'
rfm_plot_median_monetary <- function(rfm_segment_table, color = "blue", font_size = 6, sort = FALSE, ascending = FALSE, flip = FALSE, print_plot = TRUE) {

  data <- rfm_prep_median(rfm_segment_table, amount)
  plot <- rfm_plot_median(data, color, font_size, sort, ascending, flip)

  if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }

}

rfm_prep_median <- function(rfm_segment_table, metric) {

  met <- deparse(substitute(metric))

  result <-
    rfm_segment_table %>%
    data.table() %>%
    .[, .(segment, met = get(met))] %>%
    .[, .(mem = median(met)), by = segment] %>%
    .[order(mem)] %>%
    setnames(old = "mem", new = met) %>%
    setDF()

  return(result)

}

rfm_plot_median <- function(data, color, font_size, sort, ascending, flip) {

  n_fill <- nrow(data)
  cnames <- names(data)
  y_lab  <-
    switch(cnames[2],
           recency_days = "Median Recency",
           transaction_count = "Median Frequency",
           amount = "Median Monetary Value")

  if (sort) {
    if (ascending) {
      if (flip) {
        p <- ggplot(data, aes_string(x = paste0("reorder(", cnames[1], ", -", cnames[2], ", sum)"), y = cnames[2]))
      } else {
        p <- ggplot(data, aes_string(x = paste0("reorder(", cnames[1], ", ", cnames[2], ", sum)"), y = cnames[2]))
      }
    } else {
      if (flip) {
        p <- ggplot(data, aes_string(x = paste0("reorder(", cnames[1], ", ", cnames[2], ", sum)"), y = cnames[2]))
      } else {
        p <- ggplot(data, aes_string(x = paste0("reorder(", cnames[1], ", -", cnames[2], ", sum)"), y = cnames[2]))
      }
    }
  } else {
    p <- ggplot(data, aes_string(x = cnames[1], y = cnames[2]))
  }


  p <-
    p +
    geom_bar(stat = "identity", fill = color) +
    ggtitle(paste(y_lab, "by Segment")) +
    theme(plot.title = element_text(hjust = 0.5))

  if (flip) {
    p <-
      p +
      coord_flip() +
      xlab(y_lab) +
      ylab("Segment") +
      theme(axis.text.y = element_text(size = font_size))
  } else {
    p <-
      p +
      xlab("Segment") +
      ylab(y_lab) +
      theme(axis.text.x = element_text(size = font_size))
  }

  return(p)

}

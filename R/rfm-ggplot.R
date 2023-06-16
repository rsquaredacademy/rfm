rfm_gg_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label,
                           brewer_n, brewer_name, legend_title, print_plot) {

  ulm <- ceiling(max(mapdata[["monetary"]]))
  llm <- floor(min(mapdata[["monetary"]]))


  bins <- max(mapdata$frequency_score)
  guide_breaks <- round(seq(llm, ulm, length.out = bins))

  p <-
    ggplot(data = mapdata) +
    geom_tile(aes(x = frequency_score, y = recency_score, fill = monetary)) +
    ggtitle(plot_title) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    scale_fill_gradientn(limits = c(llm, ulm),
                         colours = RColorBrewer::brewer.pal(n = brewer_n,
                                                            name = brewer_name),
                         name = legend_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }
}

rfm_gg_order_dist <- function(data, flip, bar_color, plot_title, xaxis_label,
                              yaxis_label, ylim_max, count_size) {

  p <-
    data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = bar_color) +
    ggtitle(plot_title) +
    xlab(xaxis_label) +
      ylab(yaxis_label) +
      ylim(0, ylim_max)

  if (flip) {
    p <-
      p +
      coord_flip() +
      geom_text(aes(label = sprintf("%1.0f", n), y = n + 3),
                hjust = 0,
                size = count_size)
  } else {
    p <-
      p +
      geom_text(aes(label = sprintf("%1.0f", n), y = n + 3),
                position = position_dodge(0.9),
                vjust = 0,
                size = count_size)
  }

  return(p)
}

rfm_gg_hist <- function(data, hist_bins, hist_color, plot_title, xaxis_label,
                        yaxis_label, print_plot) {

  p <-
    data %>%
    ggplot(aes(score)) +
    geom_histogram(bins = hist_bins, fill = hist_color, color = I("white")) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    ggtitle(plot_title)

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }

}

rfm_gg_plot_segment_summary <- function(data, metric, sort, ascending, flip,
                                        bar_color, plot_title, xaxis_label,
                                        yaxis_label, angle, size, ylim_max) {

  if (sort) {
    if (ascending) {
      if (flip) {
        p <- ggplot(data,
                    aes(x = reorder(segment, -.data[[metric]], sum),
                        y = .data[[metric]]))
      } else {
        p <- ggplot(data,
                    aes(x = reorder(segment, .data[[metric]], sum),
                        y = .data[[metric]]))
      }
    } else {
      if (flip) {
        p <- ggplot(data,
                    aes(x = reorder(segment, .data[[metric]], sum),
                        y = .data[[metric]]))
      } else {
        p <- ggplot(data,
                    aes(x = reorder(segment, -.data[[metric]], sum),
                        y = .data[[metric]]))
      }
    }
  } else {
    p <- ggplot(data, aes(x = segment, y = .data[[metric]]))
  }

  p <-
    p +
    geom_bar(stat = "identity", fill = bar_color) +
    ggtitle(plot_title) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    ylim(0, ylim_max)

  if (flip) {
    p <-
      p +
      coord_flip() +
      geom_text(aes(label = sprintf("%1.0f", .data[[metric]]), y = .data[[metric]] + 3),
                hjust = 0,
                size = 3) +
      theme(axis.text.y = element_text(size = 7))
  } else {
    p <-
      p +
      geom_text(aes(label = sprintf("%1.0f", .data[[metric]]), y = .data[[metric]] + 3),
                position = position_dodge(0.9),
                vjust = 0,
                size = 3) +
      theme(axis.text.x = element_text(angle = angle, vjust = 0,
                                       hjust = 0, size = size))
  }

  p

}

rfm_gg_revenue_dist <- function(data, colors, labels, flip, angle, size,
                                plot_title, xaxis_label, yaxis_label) {

  p <-
    ggplot(data, aes(fill = category, y = share, x = segment)) +
    geom_bar(position="dodge", stat="identity")

  p <-
    p +
    scale_fill_manual(values = c(colors[1], colors[2]),
                      labels = c(labels[1], labels[2])) +
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
      coord_flip() +
      theme(panel.grid.major.x = element_line(colour = "#ced4da"))
  } else {
    p <-
      p +
      theme(panel.grid.major.y = element_line(colour = "#ced4da"),
            axis.text.x = element_text(angle = angle, vjust = 1,
                                       hjust = 0, size = size))
  }

  p <-
    p +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    ggtitle(plot_title)

}

rfm_plot_median <- function(data, color, sort, ascending, flip, plot_title,
                            xaxis_label, yaxis_label, font_size) {

  n_fill <- nrow(data)
  cnames <- names(data)
  y_lab  <-
    switch(cnames[2],
           recency_days = "Median Recency",
           transaction_count = "Median Frequency",
           amount = "Median Monetary Value")

  if (is.null(yaxis_label)) {
    yaxis_label <- y_lab
  }

  if (is.null(plot_title)) {
    plot_title <- paste(yaxis_label, " by Segment")
  }

  if (is.null(xaxis_label)) {
    xaxis_label <- "Segment"
  }

  if (sort) {
    if (ascending) {
      if (flip) {
        p <- ggplot(data,
                    aes(x = reorder(.data[[cnames[1]]], -.data[[cnames[2]]], sum),
                        y = .data[[cnames[2]]]))
      } else {
        p <- ggplot(data,
                    aes(x = reorder(.data[[cnames[1]]], .data[[cnames[2]]], sum),
                        y = .data[[cnames[2]]]))
      }
    } else {
      if (flip) {
        p <- ggplot(data,
                    aes(x = reorder(.data[[cnames[1]]], .data[[cnames[2]]], sum),
                        y = .data[[cnames[2]]]))
      } else {
        p <- ggplot(data,
                    aes(x = reorder(.data[[cnames[1]]], -.data[[cnames[2]]], sum),
                        y = .data[[cnames[2]]]))
      }
    }
  } else {
    p <- ggplot(data, aes(x = .data[[cnames[1]]], y = .data[[cnames[2]]]))
  }


  p <-
    p +
    geom_bar(stat = "identity", fill = color) +
    ggtitle(plot_title) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    theme(plot.title = element_text(hjust = 0.5))

  if (flip) {
    p <-
      p +
      coord_flip() +
      theme(axis.text.y = element_text(size = font_size))
  } else {
    p <-
      p +
      theme(axis.text.x = element_text(size = font_size))
  }

}

rfm_gg_segment <- function(table, metric, print_plot) {

  plot <- ggplot(table,
          aes(area = .data[[metric]],
             fill = segment,
             label = paste(toupper(segment),
                           paste0(.data[[metric]], " (", prop, "%)"),
                           sep = '\n'))) +
    geom_treemap() +
    geom_treemap_text(size = 8, place = 'centre') +
    theme(legend.position = "none")

    if (print_plot) {
    print(plot)
  } else {
    return(plot)
  }
}

rfm_gg_segment_scatter <- function(segments, x_data, y_data, plot_title,
                                   legend_title, xaxis_label, yaxis_label) {

  rfm_plot_combine(segments, x_data, y_data, xaxis_label, yaxis_label,
                   plot_title, legend_title)

}

rfm_plot_combine <- function(rfm_table, x = "amount", y = "recency_days",
                             xaxis_title = "Monetary", yaxis_title = "Recency",
                             plot_title = "Recency vs Monetary",
                             legend_title = "Segment") {

  data <- rfm_table[order(rfm_table$rfm_score), ]

  plot <-
    data %>%
    ggplot() +
    geom_point(aes(x = .data[[x]],
                   y = .data[[y]],
                   color = factor(segment),
                   group = seq_along(rfm_score))) +
    xlab(xaxis_title) +
    ylab(yaxis_title) +
    ggtitle(plot_title) +
    labs(color = legend_title)

  return(plot)
}

rfm_gg_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n, brewer_name, legend_title, print_plot) {

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
                         colours = RColorBrewer::brewer.pal(n = brewer_n, name = brewer_name),
                         name = legend_title) 

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }
}

rfm_gg_order_dist <- function(data, flip, bar_color, plot_title, xaxis_label, yaxis_label, ylim_max, count_size) {

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

rfm_gg_hist <- function(data, hist_bins, hist_color, plot_title, xaxis_label, yaxis_label, print_plot) {

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

rfm_gg_plot_segment_summary <- function(data, metric, sort, ascending, flip, bar_color, plot_title, xaxis_label, yaxis_label, angle, size, print_plot) {

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
    ylab(yaxis_label)

  if (flip) {
    p <-
      p +
      coord_flip() +
      theme(axis.text.y = element_text(size = 7))
  } else {
    p <-
      p +
      theme(axis.text.x = element_text(angle = angle, vjust = 1,
                                       hjust=1, size = size))
  }


  if (print_plot) {
      print(p)
  } else {
    return(p)
  }
}
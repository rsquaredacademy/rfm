rfm_gg_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n, brewer_name, legend_title, plot_title_justify, print_plot) {

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
                         name = legend_title) +
    theme(plot.title = element_text(hjust = plot_title_justify))

  if (print_plot) {
    print(p)
  } else {
    return(p)
  }
}

rfm_gg_order_dist <- function(data, bar_color, plot_title, xaxis_label, yaxis_label, ylim_max, count_size) {
  data %>%
    ggplot(aes(x = transaction_count, y = n)) +
    geom_bar(stat = "identity", fill = bar_color) +
    xlab(xaxis_label) +
    ylab(yaxis_label) +
    ylim(0, ylim_max) +
    ggtitle(plot_title) +
    geom_text(aes(label = sprintf("%1.0f", n), y = n + 3),
              position = position_dodge(0.9),
              vjust = 0,
              size = count_size) 
}
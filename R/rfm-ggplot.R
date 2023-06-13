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

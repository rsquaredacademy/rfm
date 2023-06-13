#' @importFrom plotly plot_ly layout config
rfm_plotly_heatmap <- function(mapdata, plot_title, xaxis_label, yaxis_label, brewer_n, brewer_name, legend_title) {

  text <- paste0("Frequency Score: ", mapdata$frequency_score,
                   "\nRecency Score: ", mapdata$recency_score,
                   "\nMean Monetary Value: ", round(mapdata$monetary, 2))

    fig <-
      plot_ly(
        data = mapdata,
        x = ~frequency_score,
        y = ~recency_score,
        z = ~monetary,
        colors = RColorBrewer::brewer.pal(n = brewer_n, name = brewer_name),
        type = "heatmap",
        colorbar = list(title = legend_title),
        hoverinfo = "text",
        hovertext = text
      )

    fig <-
      fig %>%
      layout(title = plot_title,
             xaxis = list(title = xaxis_label),
             yaxis = list(title = yaxis_label))

    fig %>%
      config(displayModeBar = FALSE)
}
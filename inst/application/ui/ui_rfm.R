tabPanel('RFM', value = 'tab_rfm', icon = icon('stats', lib = 'glyphicon'),
         
    navlistPanel(id = 'navlist_rfm',
        well = FALSE,
        widths = c(2, 10),

        source('ui/ui_rfm_score.R', local = TRUE)[[1]],
        source('ui/ui_rfm_heat_map.R', local = TRUE)[[1]],
        source('ui/ui_rfm_bar_chart.R', local = TRUE)[[1]],
        source('ui/ui_rfm_histogram.R', local = TRUE)[[1]],
        source('ui/ui_rfm_scatter_plot.R', local = TRUE)[[1]]
        
    )
)
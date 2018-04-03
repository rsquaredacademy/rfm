tabPanel('Heat Map', value = 'tab_rfm_heatmap',

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('RFM Heatmap')
      )
    ),

    hr(),

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_heatmap', height = '500px') %>% 
					withSpinner()
			)

		)

	)

)

tabPanel('Heat Map', value = 'tab_rfm_heatmap',

	fluidPage(

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

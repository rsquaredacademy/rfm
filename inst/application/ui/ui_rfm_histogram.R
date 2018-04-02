tabPanel('Histogram', value = 'tab_rfm_histogram',

	fluidPage(

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_histogram', height = '500px') %>% 
				  withSpinner()
			)

		)

	)

)


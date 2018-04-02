tabPanel('Bar Chart', value = 'tab_rfm_barchart',

	fluidPage(

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_barchart', height = '500px') %>% 
				  withSpinner()
			)

		)

	)

)


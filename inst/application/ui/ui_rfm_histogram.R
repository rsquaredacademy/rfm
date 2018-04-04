tabPanel('Histogram', value = 'tab_rfm_histogram',

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('Histograms')
      )
    ),

    hr(),

		fluidRow(

			br(),
			br(),
			column(2),
			column(8, align = 'center', 
				plotOutput('plot_histogram', height = '500px') %>% 
				  withSpinner()
			),
			column(2)

		)

	)

)


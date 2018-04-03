tabPanel('Bar Chart', value = 'tab_rfm_barchart',

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('RFM Bar Chart')
      )
    ),

    hr(),

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


tabPanel('Scatter Plots', value = 'tab_rfm_scatter',

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('Scatter Plots')
      )
    ),

    hr(),

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_scatter_1', height = '500px') %>% 
				  withSpinner()
			)

		),

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_scatter_2', height = '500px') %>% 
				  withSpinner()
			)

		),

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				plotOutput('plot_scatter_3', height = '500px') %>% 
				  withSpinner()
			)

		)

	)

)



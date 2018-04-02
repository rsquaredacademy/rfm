tabPanel('Scatter Plots', value = 'tab_rfm_scatter',

	fluidPage(

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



tabPanel("Average Recency", value = "tab_average_recency",

	fluidPage(

		fluidRow(

			br(),
			br(),
			column(2),
			column(8, align = 'center', 
				plotOutput('segment_average_recency') %>% 
					withSpinner()
			),
			column(2)

		)

	)

)
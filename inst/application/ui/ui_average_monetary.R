tabPanel("Average Monetary Value", value = "tab_average_monetary",

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('Average Monetary Value by Segment')
      )
    ),

    hr(),

		fluidRow(

			br(),
			br(),
			column(2),
			column(8, align = 'center', 
				plotOutput('segment_average_monetary') %>% 
					withSpinner()
			),
			column(2)

		)

	)

)
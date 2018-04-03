tabPanel("Segment Size", value = "tab_segment_size",

	fluidPage(

		fluidRow(

			br(),
			br(),
			column(12, align = 'center', 
				verbatimTextOutput('segment_size_out') %>% 
					withSpinner()
			)

		)

	)

)
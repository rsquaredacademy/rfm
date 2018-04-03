tabPanel("Segment Size", value = "tab_segment_size",

	fluidPage(

		fluidRow(
      column(6, align = 'left',
        h4('Segment Distribution')
      )
    ),

    hr(),

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
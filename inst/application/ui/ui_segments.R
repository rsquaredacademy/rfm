tabPanel("Segmentation", value = "tab_rfm_segments",

	fluidPage(

		fluidRow(

			column(6, align = "right", br(), h5("Number of Segments:")),
			column(6, align = "left",
				numericInput(
					inputId = "n_segments", 
					label = "",
					min = 1, 
					max = 10,
					step = 1, 
					value = 5 
				)
			)

		),

		hr(),
		
		fluidRow(
      column(3, h5('Segment')),
      column(3, h5('Recency Score')),
      column(3, h5('Frequency Score')),
      column(3, h5('Monetary Score'))
    ),

		column(12, uiOutput('segment_prep')),

    fluidRow(

      column(12, align = 'center',
        br(),
        actionButton(inputId="button_create_segments", label="Generate Segments", icon = icon('thumbs-up')),
        bsTooltip("button_create_segments", "Click here to generate segments.",
          "top", options = list(container = "body")),
        br(),
        br()
      )
    ),

    fluidRow(
    	br(),
    	dataTableOutput("segment_out")
    )

	)

)
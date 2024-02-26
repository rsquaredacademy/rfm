tabPanel('Histogram', value = 'tab_hist_prh',

	fluidPage(
		fluidRow(
			column(12, align = 'left',
				h4('Histogram')
			)
		),

		hr(),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					
					tabPanel('plotly',

						fluidRow(
							column(2,
								selectInput('histly_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "histly_xlabel", label = "X Axes Label: ",
                  value = "label"),
								selectInput('histly_horiz', 'Horizontal',
                  choices = c("TRUE" = "h", "FALSE" = "v"),
                  selected = "FALSE",  width = '150px'),
								textInput(inputId = "histly_color", label = "Color: ",
                  value = ""),
								selectInput('histly_auto', 'Auto Bin: ',
                  choices = c("TRUE" = TRUE, "FALSE" = FALSE),
                  selected = "TRUE"),
								numericInput(inputId = "histly_binstart", "Bin Start: ",
									min = 0, step = 1, value = 1)
							),

							column(2,
								textInput(inputId = "histly_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "histly_ylabel", label = "Y Axes Label: ",
                  value = "label"),
								selectInput('histly_type', 'Type',
                  choices = c("Count" = "count", "Density" = "density"),
                  selected = "Count",  width = '150px'),
								numericInput(inputId = "histly_opacity", "Opacity: ",
									min = 0, max = 1, step = 0.1, value = 1),
								numericInput(inputId = "histly_binsize", "Bin Size: ",
									min = 0, step = 1, value = 1),
								numericInput(inputId = "histly_binend", "Bin End: ",
									min = 0, step = 1, value = 1)
							),

							column(8, align = 'center',
                plotly::plotlyOutput('histly_plot_1', height = '600px')
              )
						)
					),

					tabPanel('rbokeh',

						fluidRow(
							column(2,
								selectInput('bohist_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "bohist_xlabel", label = "X Axes Label: ",
                  value = "label"),
								numericInput(inputId = "bohist_breaks", "Breaks: ",
									value = 5, min = 0, step = 1),
								selectInput(inputId = "bohist_lowest", label = "Include Lowest: ",
                	choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"),
								textInput(inputId = "bohist_color", label = "Color: ",
                  value = ""),
								textInput(inputId = "bohist_dcolor", label = "Density Color: ",
                  value = ""),
								numericInput(inputId = "bohist_dalpha", "Density Alpha: ",
									value = 1, min = 0, max = 1, step = 0.1)
							),

							column(2,
								textInput(inputId = "bohist_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "bohist_ylabel", label = "Y Axes Label: ",
                  value = "label"),
                selectInput(inputId = "bohist_density", label = "Density: ",
                	choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "FALSE"),
                selectInput(inputId = "bohist_right", label = "Right: ",
                	choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"),
                selectInput(inputId = "bohist_add", label = "Add Density Line: ",
                	choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "FALSE"),
                numericInput(inputId = "bohist_dtype", "Line Type: ",
									value = 1, min = 1, max = 5, step = 1),
                numericInput(inputId = "bohist_dwidth", "Line Width: ",
									value = 1, min = 1, step = 1)
							),

							column(8, align = 'center',
                rbokeh::rbokehOutput('bohist_plot_1', height = '600px')
              )
						)
					),

					tabPanel('highcharts',

						fluidRow(
							column(2,
								selectInput('hihist_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "hihist_xlabel", label = "X Axes Label: ",
                  value = "label")
							),

							column(2,
								textInput(inputId = "hihist_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "hihist_color", label = "Color: ",
                  value = "blue")
							),

							column(8, align = 'center',
                highcharter::highchartOutput('hihist_plot_1', height = '600px')
              )
						)
					)

				)
			)
		)
	)
)
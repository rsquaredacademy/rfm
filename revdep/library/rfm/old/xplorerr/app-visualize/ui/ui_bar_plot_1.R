tabPanel('Bar Plot', value = 'tab_bar_plot_1',

	fluidPage(
		fluidRow(
			column(12, align = 'left',
				h4('Bar Plot - I')
			)
		),

		hr(),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					
					tabPanel('plotly',

						fluidRow(
							column(2,
								selectInput('barly1_select_x', 'Variable: ',
                              choices = "", selected = ""),
								textInput(inputId = "barly1_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "barly1_color", label = "Color: ",
                  value = "blue")
							),

							column(2,
								textInput(inputId = "barly1_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "barly1_ylabel", label = "Y Axes Label: ",
                  value = "label"),
                textInput(inputId = "barly1_btext", label = "Text: ",
                  value = "")
							),

							column(8, align = 'center',
                plotly::plotlyOutput('barly1_plot_1', height = '600px')
              )
						)
					),

					tabPanel('rbokeh',

						fluidRow(
							column(2,
								selectInput('bobar1_select_x', 'Variable: ',
                              choices = "", selected = ""),
								textInput(inputId = "bobar1_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "bobar1_color", label = "Color: ",
                  value = ""),
								selectInput('bobar1_hover', 'Hover: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								),
								textInput(inputId = "bobar1_lcolor", label = "Line Color: ",
                  value = ""),
								selectInput('bobar1_xgrid', 'X Axis Grid: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								)
							),

							column(2,
								textInput(inputId = "bobar1_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "bobar1_ylabel", label = "Y Axes Label: ",
                  value = "label"),
                numericInput(inputId = "bobar1_alpha", label = "Alpha: ",
                	value = 1, min = 0, max = 1, step = 0.1),
                numericInput(inputId = "bobar1_width", label = "Width: ",
                	value = 0.9, min = 0, step = 0.1),
                numericInput(inputId = "bobar1_lalpha", label = "Line Alpha: ",
                	value = 1, min = 0, max = 1, step = 0.1),
                selectInput('bobar1_ygrid', 'Y Axis Grid: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								)
							),

							column(8, align = 'center',
                rbokeh::rbokehOutput('bobar1_plot_1', height = '600px')
              )
						)
					),

					tabPanel('highcharts',

						fluidRow(
							column(2,
								selectInput('hibar1_select_x', 'Variable: ',
                              choices = "", selected = ""),
								textInput(inputId = "hibar1_xlabel", label = "X Axes Label: ",
                  value = "label")
							),

							column(2,
								textInput(inputId = "hibar1_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "hibar1_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                highcharter::highchartOutput('hibar1_plot_1', height = '600px')
              )
						)
					)

				)
			)
		)
	)
)
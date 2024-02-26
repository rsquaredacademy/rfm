tabPanel('2 Factor Bar Plot', value = 'tab_bar_plot_2',

	fluidPage(
		fluidRow(
			column(12, align = 'left',
				h4('Bar Plot - II')
			)
		),

		hr(),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					
					tabPanel('plotly',

						fluidRow(
							column(2,
								selectInput('barly2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "barly2_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "barly2_title", label = "Title: ",
									value = "title")
							),

							column(2,
								selectInput('barly2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
                textInput(inputId = "barly2_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                plotly::plotlyOutput('barly2_plot_1', height = '600px')
              )
						)
					),

					tabPanel('rbokeh',

						fluidRow(
							column(2,
								selectInput('bobar2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								selectInput('bobar2_type', 'Type: ',
									choices = c("Stacked" = "stack", "Grouped" = "dodge", "Proportional" = "fill"), 
									selected = "Stacked"),
								textInput(inputId = "bobar2_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "bobar2_title", label = "Title: ",
									value = "title"),
								selectInput('bobar2_xgrid', 'X Axis Grid: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								),
								numericInput(inputId = "bobar2_width", label = "Width: ",
                	value = 0.9, min = 0, step = 0.1)
								
							),

							column(2,
								selectInput('bobar2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
								selectInput('bobar2_legloc', 'Legend: ',
									choices = c("Top Right" = "top_right", "Top Left" = "top_left",
										"Bottom Right" = "bottom_right", "Bottom Left" = "bottom_left", "Omit" = "NULL"), 
									selected = "Top Right"
								),
                textInput(inputId = "bobar2_ylabel", label = "Y Axes Label: ",
                  value = "label"),
                selectInput('bobar2_hover', 'Hover: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								),
								selectInput('bobar2_ygrid', 'Y Axis Grid: ',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"
								),
								numericInput(inputId = "bobar2_alpha", label = "Alpha: ",
                	value = 1, min = 0, max = 1, step = 0.1)
								
							),

							column(8, align = 'center',
                rbokeh::rbokehOutput('bobar2_plot_1', height = '600px')
              )
						)
					),

					tabPanel('highcharts',

						fluidRow(
							column(2,
								selectInput('hibar2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								selectInput('hibar2_horiz', 'Horizontal',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE),
									selected = "FALSE",  width = '150px')
								# textInput(inputId = "hibar2_xlabel", label = "X Axes Label: ",
        #           value = "label"),
								# textInput(inputId = "hibar2_title", label = "Title: ",
								# 	value = "title")
							),

							column(2,
								selectInput('hibar2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
								selectInput('hibar2_stack', 'Stacked',
									choices = c("TRUE" = TRUE, "FALSE" = FALSE),
									selected = "FALSE",  width = '150px')
                # textInput(inputId = "hibar2_ylabel", label = "Y Axes Label: ",
                #   value = "label")
							),

							column(8, align = 'center',
                highcharter::highchartOutput('hibar2_plot_1', height = '600px')
              )
						)
					)
				)
			)
		)
	)
)
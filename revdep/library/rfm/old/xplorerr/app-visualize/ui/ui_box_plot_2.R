tabPanel('2 Factor Box Plot', value = 'tab_box_plot_2',

	fluidPage(
		fluidRow(
			column(12, align = 'left',
				h4('Box Plot - II')
			)
		),

		hr(),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					
					tabPanel('plotly',

						fluidRow(
							column(2,
								selectInput('boxly2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "boxly2_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "boxly2_title", label = "Title: ",
									value = "title")
							),

							column(2,
								selectInput('boxly2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
                textInput(inputId = "boxly2_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                plotly::plotlyOutput('boxly2_plot_1', height = '600px')
              )
						)
					),

					tabPanel('rbokeh',

						fluidRow(
							column(2,
								selectInput('bobox2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								numericInput(inputId = "bobox2_oshape", label = "Outlier Shape: ",
                	value = 1, min = 0, max = 25, step = 1),
								numericInput(inputId = "bobox2_width", label = "Width: ",
                	value = 0.9, min = 0, max = 1, step = 0.1),
								selectInput('bobox2_xgrid', 'X Axis Grid: ',
                              choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"),
								textInput(inputId = "bobox2_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "bobox2_title", label = "Title: ",
									value = "title")
							),

							column(2,
								selectInput('bobox2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
								numericInput(inputId = "bobox2_osize", label = "Outlier Size: ",
                	value = 10, min = 0, step = 1),
								numericInput(inputId = "bobox2_alpha", label = "Alpha: ",
                	value = 1, min = 0, max = 1, step = 0.1),
								selectInput('bobox2_ygrid', 'Y Axis Grid: ',
                              choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE"),
								textInput(inputId = "bobox2_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                rbokeh::rbokehOutput('bobox2_plot_1', height = '600px')
              )
						)
					),

					tabPanel('highcharts',

						fluidRow(
							column(2,
								selectInput('hibox2_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "hibox2_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "hibox2_title", label = "Title: ",
									value = "title")
							),

							column(2,
								selectInput('hibox2_select_y', 'Variable 2: ',
                              choices = "", selected = ""),
                textInput(inputId = "hibox2_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                highcharter::highchartOutput('hibox2_plot_1', height = '600px')
              )
						)
					)

				)
			)
		)
	)
)
tabPanel('Box Plot', value = 'tab_box_plot_1',

	fluidPage(
		fluidRow(
			column(12, align = 'left',
				h4('Box Plot - I')
			)
		),

		hr(),

		fluidRow(
			column(12,
				tabsetPanel(type = 'tabs',
					
					tabPanel('plotly',

						fluidRow(
							column(2,
								selectInput('boxly1_select_x', 'Variable 1: ',
                              choices = "", selected = ""),
								textInput(inputId = "boxly1_xlabel", label = "X Axes Label: ",
                  value = "label")
							),

							column(2,
								textInput(inputId = "boxly1_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "boxly1_ylabel", label = "Y Axes Label: ",
                  value = "label")
							),

							column(8, align = 'center',
                plotly::plotlyOutput('boxly1_plot_1', height = '600px')
              )
						)
					),

					tabPanel('rbokeh',

						fluidRow(
							column(2,
								selectInput('bobox1_select_x', 'Variable: ',
                              choices = "", selected = ""),
								textInput(inputId = "bobox1_xlabel", label = "X Axes Label: ",
                  value = "label"),
								textInput(inputId = "bobox1_color", label = "Color: ",
                  value = ""),
								numericInput(inputId = "bobox1_oshape", label = "Outlier Shape: ",
                	value = 1, min = 0, max = 25, step = 1),
								numericInput(inputId = "bobox1_width", label = "Width: ",
                	value = 0.9, min = 0, max = 1, step = 0.1),
								selectInput('bobox1_xgrid', 'X Axis Grid: ',
                              choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE")
							),

							column(2,
								textInput(inputId = "bobox1_title", label = "Title: ",
									value = "title"),
                textInput(inputId = "bobox1_ylabel", label = "Y Axes Label: ",
                  value = "label"),
                numericInput(inputId = "bobox1_alpha", label = "Alpha: ",
                	value = 1, min = 0, max = 1, step = 0.1),
                numericInput(inputId = "bobox1_osize", label = "Outlier Size: ",
                	value = 10, min = 0, step = 1),
                textInput(inputId = "bobox1_lcolor", label = "Line Color: ",
                  value = ""),
                selectInput('bobox1_ygrid', 'Y Axis Grid: ',
                              choices = c("TRUE" = TRUE, "FALSE" = FALSE), selected = "TRUE")
							),

							column(8, align = 'center',
                rbokeh::rbokehOutput('bobox1_plot_1', height = '600px')
              )
						)
					)

				)
			)
		)
	)
)
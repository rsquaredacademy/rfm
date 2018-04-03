tabPanel('RFM Score', value = 'tab_rfm_score',

	# check box for transcation or customer data
	fluidPage(

    fluidRow(
      column(6, align = 'left',
        h4('Generate RFM Score')
      )
    ),

    hr(),

		fluidRow(
      column(2, align = 'right', br(), h5('Data Type:')),
      column(4, align = 'left',
        selectInput('rfm_data_type', label = '', width = '300px',
          choices = c("Customer Data", "Transaction Data"),
          selected = "Customer Data")
        )
    ),

		hr(),

		fluidRow(
			column(12, uiOutput("ui_helplink"))
		),

		fluidRow(
      column(4, uiOutput("ui_customerid")),
      column(4, uiOutput("ui_orderdate")),
      column(4, uiOutput("ui_revenue"))
    ),

    fluidRow(
    	column(4, uiOutput("ui_analysisdate")),
    	column(4, uiOutput("ui_recency")),
    	column(4, uiOutput("ui_frequency"))
    ),

    fluidRow(
      column(4, uiOutput("ui_monetary")),
    	column(4, uiOutput("ui_extra"))
    ),

    fluidRow(
    	column(12, align = "center",
    		actionButton(inputId = 'submit_rfm_score', label = 'Submit', width = '120px', icon = icon('check')),
                bsTooltip("submit_summary", "Click here to view RFM score.",
                              "bottom", options = list(container = "body"))
    	)
    ),

    fluidRow(
      br(),
      dataTableOutput('rfm_score_out')
    )

	)

)
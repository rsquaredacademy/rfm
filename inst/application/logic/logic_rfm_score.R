observeEvent(input$rfm_data_type == "Customer Data", {

	updateSelectInput(
		session,
		inputId = "rfm_customer_id_c",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

	updateSelectInput(
		session,
		inputId = "rfm_n_transactions_c",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

	updateSelectInput(
		session,
		inputId = "rfm_recency_days_c",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

	updateSelectInput(
		session,
		inputId = "rfm_total_revenue_c",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

}) 

observeEvent(input$rfm_data_type == "Transaction Data", {

	updateSelectInput(
		session,
		inputId = "rfm_customer_id_t",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

	updateSelectInput(
		session,
		inputId = "rfm_order_date_t",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

	updateSelectInput(
		session,
		inputId = "rfm_revenue_t",
		choices = names(final_sel$a),
		selected = names(final_sel$a)
	)

}) 

output$ui_helplink <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(6, align = 'left',
          h4('RFM Analysis'),
          p('Recency, frequency and monetary value analysis for customer level data.')
        ),
        column(6, align = 'right',
          actionButton(inputId='rvsp1', label="Help", icon = icon("question-circle"),
            onclick ="window.open('https://rfm.rsquaredacademy.com/reference/rfm_table_customer.html', '_blank')")
        )

		)

	} else {

		fluidRow(

			column(6, align = 'left',
          h4('RFM Analysis'),
          p('Recency, frequency and monetary value analysis for transaction level data.')
        ),
        column(6, align = 'right',
          actionButton(inputId='rvsp1', label="Help", icon = icon("question-circle"),
            onclick ="window.open('https://rfm.rsquaredacademy.com/reference/rfm_table_order.html', '_blank')")
        )

		)

	}

})

output$ui_customerid <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Unique ID:")
			),

			column(8, align = "left",
				selectInput("rfm_customer_id_c", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_customer_id_c", "Select the variable representing the unique id of the customer.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Unique ID:")
			),

			column(8, align = "left",
				selectInput("rfm_customer_id_t", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_customer_id_t", "Select the variable representing the unique id of the customer.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)		

	}

})

output$ui_orderdate <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Orders:")
			),

			column(8, align = "left",
				selectInput("rfm_n_transactions_c", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_n_transactions_c", "Select the variable representing the number of orders/purchases.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Order Date:")
			),

			column(8, align = "left",
				selectInput("rfm_order_date_t", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_order_date_t", "Select the variable representing the date of the order/transaction.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_revenue <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(8, align = "right",
				br(),
				h6("Days since last transaction:")
			),

			column(4, align = "left",
				selectInput("rfm_recency_days_c", label = '',
					choices = "", selected = "", width = '100px'
				),
	      bsTooltip("rfm_recency_days_c", "Select the variable representing the days since last transaction.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Revenue:")
			),

			column(8, align = "left",
				selectInput("rfm_revenue_t", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_revenue_t", "Select the variable representing the total revenue from the transaction.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_analysisdate <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Revenue:")
			),

			column(8, align = "left",
				selectInput("rfm_total_revenue_c", label = '',
					choices = "", selected = "", width = '150px'
				),
	      bsTooltip("rfm_total_revenue_c", "Select the variable representing the total revenue from the customer.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Analysis Date:")
			),

			column(8, align = "left",
				dateInput("rfm_analysis_date_t", label = ''),
	      bsTooltip("rfm_analysis_date_t", "Select the date of analysis.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_recency <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(4, align = "right",
				br(),
				h5("Analysis Date:")
			),

			column(8, align = "left",
				dateInput("rfm_analysis_date_t", label = ''),
	      bsTooltip("rfm_analysis_date_c", "Select the date of analysis.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Recency Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_recency_bins_t", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_recency_bins_t", "Specify the number of bins for recency.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_frequency <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Recency Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_recency_bins_c", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_recency_bins_c", "Specify the number of bins for recency.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Frequency Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_frequency_bins_t", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_recency_bins_t", "Specify the number of bins for recency.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_monetary <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Frequency Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_frequency_bins_c", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_frequency_bins_c", "Specify the number of bins for frequency.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} else {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Monetary Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_monetary_bins_t", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_monetary_bins_t", "Specify the number of bins for monetary value.",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	}

})

output$ui_extra <- renderUI({

	if (input$rfm_data_type == "Customer Data") {

		fluidRow(

			column(6, align = "right",
				br(),
				h5("Monetary Bins:")
			),

			column(6, align = "left",
				numericInput("rfm_monetary_bins_c", label = '',
					min = 1, step = 1, value = 5, width = '70px'
				),
	      bsTooltip("rfm_monetary_bins_c", "Specify the number of bins for monetary value",
	      	"bottom", options = list(container = "body")
	      )
			)

		)

	} 

})


comp_rfm_score <- eventReactive(input$submit_rfm_score, {

	if (input$rfm_data_type == "Customer Data") {

		rfm_table_customer(data = final_sel$a, customer_id = !! sym(as.character(input$rfm_customer_id_c)),
			n_transactions = !! sym(as.character(input$rfm_n_transactions_c)), 
			recency_days = !! sym(as.character(input$rfm_recency_days_c)), 
			total_revenue = !! sym(as.character(input$rfm_total_revenue_c)),
			analysis_date = input$rfm_analysis_date_c, recency_bins = input$rfm_recency_bins_c,
			frequency_bins = input$rfm_frequency_bins_c, monetary_bins = input$rfm_monetary_bins_c)

	} else {

		rfm_table_order(data = final_sel$a, customer_id = !! sym(as.character(input$rfm_customer_id_t)),
			order_date = !! sym(as.character(input$rfm_order_date_t)), 
			revenue = !! sym(as.character(input$rfm_revenue_t)), 		
			analysis_date = input$rfm_analysis_date_t, recency_bins = input$rfm_recency_bins_t,
			frequency_bins = input$rfm_frequency_bins_t, monetary_bins = input$rfm_monetary_bins_t)

	}

}) 


output$rfm_score_out <- renderDataTable({
	comp_rfm_score() %>%
	  use_series(rfm) %>%
	  as.data.frame()

})

generate_heatmap <- eventReactive(input$submit_rfm_score, {
  rfm_heatmap(comp_rfm_score())
})


output$plot_heatmap <- renderPlot({
  print(generate_heatmap())
})

generate_barchart <- eventReactive(input$submit_rfm_score, {
  rfm_bar_chart(comp_rfm_score())
})


output$plot_barchart <- renderPlot({
  print(generate_barchart())
})

generate_histogram <- eventReactive(input$submit_rfm_score, {
  rfm_histograms(comp_rfm_score())
})


output$plot_histogram <- renderPlot({
  print(generate_histogram())
})

generate_scatter_1 <- eventReactive(input$submit_rfm_score, {
  rfm_rm_plot(comp_rfm_score())
})


output$plot_scatter_1 <- renderPlot({
  print(generate_scatter_1())
})

generate_scatter_2 <- eventReactive(input$submit_rfm_score, {
  rfm_fm_plot(comp_rfm_score())
})

output$plot_scatter_2 <- renderPlot({
  print(generate_scatter_2())
})


generate_scatter_3 <- eventReactive(input$submit_rfm_score, {
  rfm_rf_plot(comp_rfm_score())
})

output$plot_scatter_3 <- renderPlot({
  print(generate_scatter_3())
})



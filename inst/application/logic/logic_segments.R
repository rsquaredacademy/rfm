library(purrr)
library(ggplot2)

output$segment_prep <- renderUI({

	ncol <- as.integer(input$n_segments)

	lapply(1:ncol, function(i) {

    fluidRow(

      column(3,
        textInput(paste("segment_name_", i),
        label = '',  width = '150px',
        value = "")
      ),
      column(3,
        sliderInput(paste("recency_interval_", i),
          label = '', min = 1, max = 5, value = c(2, 4), step = 1)
      ),
      column(3,
        sliderInput(paste("frequency_interval_", i),
          label = '', min = 1, max = 5, value = c(2, 4), step = 1)
      ),
      column(3,
        sliderInput(paste("monetary_interval_", i),
          label = '', min = 1, max = 5, value = c(2, 4), step = 1)
      )
    )

  })

})

segment_names <- reactive({
  
  ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("segment_name_", i)]]
  }))

  unlist(collect)

})

recency_lower <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("recency_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(1)

})

recency_upper <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("recency_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(2)

})

frequency_lower <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("frequency_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(1)

})

frequency_upper <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("frequency_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(2)

})

monetary_lower <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("monetary_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(1)

})

monetary_upper <- reactive({

	ncol <- as.integer(input$n_segments)

  collect <- list(lapply(1:ncol, function(i) {
    input[[paste("monetary_interval_", i)]]
  }))

  collect[[1]] %>%
    map_int(2)

})

prep_segment <- eventReactive(input$button_create_segments, {

	rfm_score_table <- 
		comp_rfm_score() %>%
		  use_series(rfm)

	for (i in seq_len(input$n_segments)) {
		rfm_score_table$segment[((rfm_score_table$recency_score %>% between(recency_lower()[i], recency_upper()[i])) & 
		  (rfm_score_table$frequency_score %>% between(frequency_lower()[i], frequency_upper()[i])) &
		  (rfm_score_table$monetary_score %>% between(monetary_lower()[i], monetary_upper()[i])))] <- segment_names()[i]
	}

	rfm_score_table$segment[is.na(rfm_score_table$segment)] <- "Others"

	rfm_score_table %>%
	  select(
	    customer_id, segment, rfm_score, transaction_count, recency_days,
	    amount
	  )

})

output$segment_out <- renderDataTable({
	prep_segment() 
})

output$segment_size_out <- renderPrint({

	prep_segment() %>%
	  count(segment) %>%
	  arrange(desc(n)) %>%
	  rename(Segment = segment, Count = n) %>% 
	  kable() %>%
  	kable_styling(full_width = TRUE, font_size = 30)

})

fill_segments <- reactive({
	input$n_segments + 1
})

output$segment_average_recency <- renderPlot({

	prep_segment() %>%
	  group_by(segment) %>%
	  select(segment, recency_days) %>%
	  summarize(mean(recency_days)) %>%
	  rename(segment = segment, avg_recency = `mean(recency_days)`) %>%
	  ggplot(aes(segment, avg_recency)) +
	  geom_bar(stat = "identity", fill = brewer.pal(n = fill_segments(), name = "Set1")) +
	  xlab("Segment") + ylab("Average Recency") +
	  ggtitle("Average Recency by Segment") +
	  coord_flip() +
	  theme(
	    plot.title = element_text(hjust = 0.5)
	  )

})
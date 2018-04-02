# output
output$screen <- renderPrint({
    ds_screener(final_sel$a)
})

observeEvent(input$finalok, {
	updateNavbarPage(session, 'mainpage', selected = 'tab_rfm')
	updateNavlistPanel(session, 'navlist_rfm', 'tab_rfm_score')
})

final_split <- reactiveValues(train = NULL)

observeEvent(input$finalok, {
	final_split$train <- final_sel$a
})

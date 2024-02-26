source('helper/histly.R')
source('helper/bohist.R')
source('helper/highhist.R')

observeEvent(input$finalok, {
        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'histly_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bohist_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hihist_select_x',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'histly_select_x', choices = '', selected = '')
             updateSelectInput(session, 'bohist_select_x', choices = '', selected = '')
             updateSelectInput(session, 'hihist_select_x', choices = '', selected = '')
        } else {
             updateSelectInput(session, 'histly_select_x', choices = names(num_data))
             updateSelectInput(session, 'bohist_select_x', choices = names(num_data))
             updateSelectInput(session, 'hihist_select_x', choices = names(num_data))
        }

})

observeEvent(input$submit_part_train_per, {

        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'histly_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bohist_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hihist_select_x',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'histly_select_x', choices = '', selected = '')
             updateSelectInput(session, 'bohist_select_x', choices = '', selected = '')
             updateSelectInput(session, 'hihist_select_x', choices = '', selected = '')
        } else {
             updateSelectInput(session, 'histly_select_x', choices = names(num_data))
             updateSelectInput(session, 'bohist_select_x', choices = names(num_data))
             updateSelectInput(session, 'hihist_select_x', choices = names(num_data))
        }

})


histlydata <- reactive({
  req(input$histly_select_x)
  final_split$train[, input$histly_select_x]
})

observe({
  updateNumericInput(session, "histly_binstart", value = min(histlydata()))
  updateNumericInput(session, "histly_binend", value = max(histlydata()))
})

output$histly_plot_1 <- plotly::renderPlotly({
  if (input$histly_auto == TRUE) {  
      histly(data = final_split$train, y = input$histly_select_x, 
        title = input$histly_title, x_title = input$histly_xlabel, hist_col = input$histly_color,
        y_title = input$histly_ylabel, hist_orient = input$histly_horiz, 
        hist_opacity = input$histly_opacity, hist_type = input$histly_type, 
        auto_binx = input$histly_auto)
  } else {
    histly(data = final_split$train, y = input$histly_select_x, 
        title = input$histly_title, x_title = input$histly_xlabel, hist_col = input$histly_color,
        y_title = input$histly_ylabel, hist_orient = input$histly_horiz, 
        hist_opacity = input$histly_opacity, hist_type = input$histly_type, 
        auto_binx = input$histly_auto, xbins_size = input$histly_binsize,
        xbins_start = input$histly_binstart, xbins_end = input$histly_binend)
  }
})

output$bohist_plot_1 <- rbokeh::renderRbokeh({
  bohist(data = final_split$train, x_data = input$bohist_select_x, 
    fig_title = input$bohist_title, x_lab = input$bohist_xlabel,
    y_lab = input$bohist_ylabel, h_breaks = input$bohist_breaks, 
    h_freq = input$bohist_density, h_incl_low = input$bohist_lowest, 
    h_right = input$bohist_right, h_fill_col = input$bohist_color, 
    add_density = input$bohist_add, den_col = input$bohist_dcolor, 
    den_alpha = input$bohist_dalpha, den_width = input$bohist_dwidth, 
    den_type = input$bohist_dtype)
})

output$hihist_plot_1 <- highcharter::renderHighchart({
  highist(data = final_split$train, column = input$hihist_select_x,
    xlab = input$hihist_xlabel, color = input$hihist_color)
})

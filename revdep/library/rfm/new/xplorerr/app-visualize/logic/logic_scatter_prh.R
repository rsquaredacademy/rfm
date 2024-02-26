source('helper/scatterly.R')
source('helper/boscatter.R')
source('helper/hscatter.R')

observeEvent(input$finalok, {

        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'scatly_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'scatly_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'boscat_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'boscat_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hiscat_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hiscat_select_y',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'scatly_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'scatly_select_y',
              choices = '', selected = '')
             updateSelectInput(session, 'boscat_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'boscat_select_y',
              choices = '', selected = '')
             updateSelectInput(session, 'hiscat_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'hiscat_select_y',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'scatly_select_x', choices = names(num_data))
             updateSelectInput(session, 'scatly_select_y', choices = names(num_data))
             updateSelectInput(session, 'boscat_select_x', choices = names(num_data))
             updateSelectInput(session, 'boscat_select_y', choices = names(num_data))
             updateSelectInput(session, 'hiscat_select_x', choices = names(num_data))
             updateSelectInput(session, 'hiscat_select_y', choices = names(num_data))
        }

})

observeEvent(input$submit_part_train_per, {

        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'scatly_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'scatly_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'boscat_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'boscat_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hiscat_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hiscat_select_y',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'scatly_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'scatly_select_y',
              choices = '', selected = '')
             updateSelectInput(session, 'boscat_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'boscat_select_y',
              choices = '', selected = '')
             updateSelectInput(session, 'hiscat_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'hiscat_select_y',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'scatly_select_x', choices = names(num_data))
             updateSelectInput(session, 'scatly_select_y', choices = names(num_data))
             updateSelectInput(session, 'boscat_select_x', choices = names(num_data))
             updateSelectInput(session, 'boscat_select_y', choices = names(num_data))
             updateSelectInput(session, 'hiscat_select_x', choices = names(num_data))
             updateSelectInput(session, 'hiscat_select_y', choices = names(num_data))
        }
})


output$scatly_plot_1 <- plotly::renderPlotly({
  scatterly(data = final_split$train, y = input$scatly_select_y, 
    x = input$scatly_select_x, title = input$scatly_title, show_legend = FALSE,
    x_title = input$scatly_xlabel, y_title = input$scatly_ylabel,
    text = input$scatly_text, color = input$scatly_color, opacity = input$scatly_opacity, 
    symbol = input$scatly_symbol, size = input$scatly_size, 
    fit_line = input$scatly_fit, line_col = input$scatly_lcol,
    line_type = input$scatly_ltype, line_width = input$scatly_lsize)
})

# fitstat <- eventReactive({
#   model <- lm(input$boscat_select_y ~ input$boscat_select_x, data = final_split$train)
#   return(model$coefficients)
# })

# intercept <- reactive({
#   fitstat()[[1]]
# })

# slope <- reactive({
#   fitstat()[[2]]
# })

# observe({
#   updateNumericInput(session, inputId = "boscat_fint", value = intercept())
#   updateNumericInput(session, inputId = "boscat_fslope", value = slope())
# })

output$boscat_plot_1 <- rbokeh::renderRbokeh({
  bokatter(data = final_split$train, y_data = input$boscat_select_y, 
    x_data = input$boscat_select_x, fig_title = input$boscat_title, 
    x_lab = input$boscat_xlabel, y_lab = input$boscat_ylabel,
    x_grid = input$boscat_xgrid, y_grid = input$boscat_ygrid, 
    glyph = input$boscat_shape, point_size = input$boscat_size, 
    inner_col = input$boscat_color, inner_alpha = input$boscat_alpha, 
    add_line = input$boscat_fitline, line_a = input$boscat_fint,  
    line_b = input$boscat_fslope, line_color  = input$boscat_lcolor, 
    line_alpha = input$boscat_lalpha, line_width = input$boscat_lwidth, 
    line_type = input$boscat_ltype)
})


output$hiscat_plot_1 <- highcharter::renderHighchart({
  hscatter(data = final_split$train, x = input$hiscat_select_x, 
    y = input$hiscat_select_y, xax_title = input$hiscat_xlabel, 
    yax_title = input$hiscat_ylabel, point_size = input$hiscat_size, 
    scatter_series_name = ' ', point_col = input$hiscat_color, 
    point_shape = input$hiscat_symbol, fit_line = input$hiscat_fit, 
    line_col = input$hiscat_lcol, line_width = input$hiscat_lsize, 
    point_on_line = FALSE, title = input$hiscat_title, sub = input$hiscat_subtitle)
})
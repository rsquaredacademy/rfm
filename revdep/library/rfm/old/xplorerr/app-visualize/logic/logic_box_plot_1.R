source('helper/boxly1.R')
source('helper/bobox.R')

observeEvent(input$finalok, {
        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'boxly1_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bobox1_select_x',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'boxly1_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'bobox1_select_x',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'boxly1_select_x', choices = names(num_data))
             updateSelectInput(session, 'bobox1_select_x', choices = names(num_data))
        }

})

observeEvent(input$submit_part_train_per, {
        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'boxly1_select_x',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bobox1_select_x',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'boxly1_select_x',
              choices = '', selected = '')
             updateSelectInput(session, 'bobox1_select_x',
              choices = '', selected = '')
        } else {
             updateSelectInput(session, 'boxly1_select_x', choices = names(num_data))
             updateSelectInput(session, 'bobox1_select_x', choices = names(num_data))
        }

})


output$boxly1_plot_1 <- plotly::renderPlotly({
  boxly1(data = final_split$train, y = input$boxly1_select_x, 
    title = input$boxly1_title, name = input$boxly1_xlabel,
    x_title = NULL, y_title = input$boxly1_ylabel)
})

output$bobox1_plot_1 <- rbokeh::renderRbokeh({
  bobox(data = final_split$train, x_data = input$bobox1_select_x, 
    fig_title = input$bobox1_title, x_lab = input$bobox1_xlabel,
    y_lab = input$bobox1_ylabel, ,
    x_grid = input$bobox1_xgrid, y_grid = input$bobox1_ygrid, 
    box_w = input$bobox1_width, box_col = input$bobox1_color, 
    box_alp = input$bobox1_alpha, box_l_col = input$bobox1_lcolor,
    box_out_gly = input$bobox1_oshape, box_out_size = input$bobox1_osize)
})

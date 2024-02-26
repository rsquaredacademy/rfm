source('helper/boxly2.R')
source('helper/bobox2.R')
source('helper/hibox2.R')

observeEvent(input$finalok, {
        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'boxly2_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bobox2_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hibox2_select_y',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'boxly2_select_y', choices = '', selected = '')
             updateSelectInput(session, 'bobox2_select_y', choices = '', selected = '')
             updateSelectInput(session, 'hibox2_select_y', choices = '', selected = '')
        } else {
             updateSelectInput(session, 'boxly2_select_y', choices = names(num_data))
             updateSelectInput(session, 'bobox2_select_y', choices = names(num_data))
             updateSelectInput(session, 'hibox2_select_y', choices = names(num_data))
        }

        f_data <- final_split$train[, sapply(final_split$train, is.factor)]
        # validate(need(!dim(f_data)[2] == 0, 'No factor variables in the data.'))
        if (is.null(dim(f_data))) {
        k <- final_split$train %>% map(is.factor) %>% unlist()
        j <- names(which(k == TRUE))
        fdata <- tibble::as_data_frame(f_data)
        colnames(fdata) <- j
        updateSelectInput(session, 'boxly2_select_x',
              choices = names(fdata), selected = names(fdata))
        updateSelectInput(session, 'bobox2_select_x',
              choices = names(fdata), selected = names(fdata))
        updateSelectInput(session, 'hibox2_select_x',
              choices = names(fdata), selected = names(fdata))
        } else if (dim(f_data)[2] == 0) {
          updateSelectInput(session, 'boxly2_select_x', choices = '', selected = '')
          updateSelectInput(session, 'bobox2_select_x', choices = '', selected = '')
          updateSelectInput(session, 'hibox2_select_x', choices = '', selected = '')
        } else {
          updateSelectInput(session, 'boxly2_select_x', choices = names(f_data))
          updateSelectInput(session, 'bobox2_select_x', choices = names(f_data))
          updateSelectInput(session, 'hibox2_select_x', choices = names(f_data))
        }

})

observeEvent(input$submit_part_train_per, {
        
        num_data <- final_split$train[, sapply(final_split$train, is.numeric)]
        if (is.null(dim(num_data))) {
            k <- final_split$train %>% map(is.numeric) %>% unlist()
            j <- names(which(k == TRUE))
            numdata <- tibble::as_data_frame(num_data)
            colnames(numdata) <- j
            updateSelectInput(session, 'boxly2_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'bobox2_select_y',
              choices = names(numdata), selected = names(numdata))
            updateSelectInput(session, 'hibox2_select_y',
              choices = names(numdata), selected = names(numdata))
        } else if (ncol(num_data) < 1) {
             updateSelectInput(session, 'boxly2_select_y', choices = '', selected = '')
             updateSelectInput(session, 'bobox2_select_y', choices = '', selected = '')
             updateSelectInput(session, 'hibox2_select_y', choices = '', selected = '')
        } else {
             updateSelectInput(session, 'boxly2_select_y', choices = names(num_data))
             updateSelectInput(session, 'bobox2_select_y', choices = names(num_data))
             updateSelectInput(session, 'hibox2_select_y', choices = names(num_data))
        }

        f_data <- final_split$train[, sapply(final_split$train, is.factor)]
        # validate(need(!dim(f_data)[2] == 0, 'No factor variables in the data.'))
        if (is.null(dim(f_data))) {
        k <- final_split$train %>% map(is.factor) %>% unlist()
        j <- names(which(k == TRUE))
        fdata <- tibble::as_data_frame(f_data)
        colnames(fdata) <- j
        updateSelectInput(session, 'boxly2_select_x',
              choices = names(fdata), selected = names(fdata))
        updateSelectInput(session, 'bobox2_select_x',
              choices = names(fdata), selected = names(fdata))
        updateSelectInput(session, 'hibox2_select_x',
              choices = names(fdata), selected = names(fdata))
        } else if (dim(f_data)[2] == 0) {
          updateSelectInput(session, 'boxly2_select_x', choices = '', selected = '')
          updateSelectInput(session, 'bobox2_select_x', choices = '', selected = '')
          updateSelectInput(session, 'hibox2_select_x', choices = '', selected = '')
        } else {
          updateSelectInput(session, 'boxly2_select_x', choices = names(f_data))
          updateSelectInput(session, 'bobox2_select_x', choices = names(f_data))
          updateSelectInput(session, 'hibox2_select_x', choices = names(f_data))
        }
})


output$boxly2_plot_1 <- plotly::renderPlotly({
  boxly2(data = final_split$train, y = input$boxly2_select_y, 
    x = input$boxly2_select_x, title = input$boxly2_title, 
    x_title = input$boxly2_ylabel, y_title = input$boxly2_ylabel)
})


output$bobox2_plot_1 <- rbokeh::renderRbokeh({
  bobox2(data = final_split$train, y_data = input$bobox2_select_y, 
    x_data = input$bobox2_select_x, fig_title = input$bobox2_title, 
    x_lab = input$bobox2_ylabel, y_lab = input$bobox2_ylabel,
    x_grid = input$bobox2_xgrid, y_grid = input$bobox2_ygrid, 
    box_w = input$bobox2_width, box_alp = input$bobox2_alpha, 
    box_out_gly = input$bobox2_oshape, box_out_size = input$bobox2_osize,
    legend_loc = input$bobox2_legloc)
})

output$hibox2_plot_1 <- highcharter::renderHighchart({
  highbox(data = final_split$train, y = input$hibox2_select_y, 
    x = input$hibox2_select_x, title = input$hibox2_title, 
    xax_title = input$hibox2_ylabel, yax_title = input$hibox2_ylabel)
})

bobar <- function(x_data = NULL, data = NULL, fig_title = NULL, 
                  x_lab = NULL, y_lab = NULL, x_grid = TRUE, 
                  y_grid = TRUE, bar_width = 0.9, bar_hover = TRUE, 
                  bar_col = NULL, bar_f_alpha = 1, 
                  bar_l_col = NULL, bar_l_alpha = 1) {
  
  xdata <- data %>%
    select_(x_data) %>%
    table() %>%
    as.vector()
  
  xlev <- data %>%
    select_(x_data) %>%
    unlist() %>%
    levels()
  
  ba <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, 
               xgrid = x_grid, ygrid = y_grid, legend_location = NULL) %>% 
    ly_bar(x = xlev, y = xdata, hover = bar_hover, 
           width = bar_width, fill_color = bar_col, fill_alpha = bar_f_alpha, 
           line_color = bar_l_col, line_alpha = bar_l_alpha)  
  
  ba
  
}
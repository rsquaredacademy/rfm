bobar2 <- function(data = NULL, var_1 = NULL, var_2 = NULL, fig_title = NULL,
                   x_lab = NULL, y_lab = NULL, x_grid = TRUE, y_grid = TRUE, 
                   legend_loc = 'top_right', bar_pos = 'dodge',
                   bar_hover = TRUE, bar_width = 0.9, bar_f_alpha = 1) {
  
  ba <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, 
               xgrid = x_grid, ygrid = y_grid, legend_location = legend_loc) %>%
    ly_bar(data = mtcars, x = var_1, y = rep(1, length(var_1)), position = bar_pos,
           color = var_2, hover = bar_hover, width = bar_width, fill_alpha = bar_f_alpha) 
  
  ba
  
}
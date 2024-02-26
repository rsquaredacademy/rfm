bobox2 <- function(data = NULL, x_data = NULL, y_data = NULL, fig_title = NULL,
                   x_lab = NULL, y_lab = NULL, x_grid = TRUE, y_grid = TRUE, 
                   legend_loc = 'top_right', box_w = 0.9, 
                   box_alp = 1, box_out_gly = 1, box_out_size = 10) {
  
  p <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, xgrid = x_grid, 
              ygrid = y_grid, legend_location = legend_loc) %>%
    ly_boxplot(data = data, x = x_data, y = y_data, width = box_w,
               fill_alpha = box_alp, outlier_glyph = box_out_gly, 
               outlier_size = box_out_size)  
  
  p
  
}

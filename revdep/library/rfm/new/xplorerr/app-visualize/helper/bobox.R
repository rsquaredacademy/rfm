bobox <- function(x_data = NULL, data = NULL, fig_title = NULL, x_lab = NULL, 
                  y_lab = NULL, x_grid = TRUE, y_grid = TRUE, legend_loc = NULL,
                  box_w = 0.9, box_col = NULL, box_alp = 1, box_l_col = NULL,
                  box_out_gly = 1, box_out_size = 10) {
  
  p <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, xgrid = x_grid, 
              ygrid = y_grid, legend_location = legend_loc) %>%
    ly_boxplot(x = x_data, data = data, width = box_w, fill_color = box_col, 
              fill_alpha = box_alp, line_color = box_l_col,
              outlier_glyph = box_out_gly, outlier_size = box_out_size)
  
  p
  
}
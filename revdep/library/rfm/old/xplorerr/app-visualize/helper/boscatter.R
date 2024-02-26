bokatter <- function(data = NULL, x_data = NULL, y_data = NULL, fig_title = NULL,
                     x_lab = NULL, y_lab = NULL, x_grid = TRUE, y_grid = TRUE, 
                     glyph = 21, point_size = 10, inner_col = 'blue', inner_alpha = 1, 
                     add_line = FALSE, line_a = NULL,  line_b = NULL,
                     line_color  = 'black', line_alpha = NULL, line_width = 1, 
                     line_type = 1) {
  
  suppressWarnings(
    p <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, 
                xgrid = x_grid, ygrid = y_grid) %>%
      ly_points(x = x_data, y = y_data, data = data, glyph = glyph, 
                size = point_size, fill_color = inner_col, 
                fill_alpha = inner_alpha, hover = list(x_data, y_data)) 
  )

  
  suppressWarnings(
    if(add_line) {
      suppressWarnings(  
        p <- p %>%
          ly_abline(a = line_a, b = line_b, color = line_color, width = line_width, 
                    alpha = line_alpha, type = line_type, legend = NULL)
      )
        
    }
  )
   
  p
  
}


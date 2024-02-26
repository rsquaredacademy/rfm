boline <- function(data = data, x_data = NULL, y_data = NULL, fig_title = NULL, 
                   x_lab = NULL, y_lab = NULL, l_color = NULL, l_type = 1, l_width = 1, 
                   l_alpha = 1) {
  
  suppressWarnings(
    p <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, legend_location = NULL) %>%
      ly_lines(x = x_data, y = y_data, data = data, 
               color = l_color, type = l_type, width = l_width,
               alpha = l_alpha, legend = FALSE) 
  )
  
  p
  
}
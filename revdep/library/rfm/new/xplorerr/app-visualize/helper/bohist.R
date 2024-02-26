bohist <- function(data = NULL, x_data = NULL, fig_title = NULL, x_lab = NULL, y_lab = NULL,
                   h_breaks = 5, h_freq = TRUE, h_incl_low = TRUE, 
                   h_right = TRUE, h_fill_col = 'blue', add_density = FALSE,
                   den_col = 'black', den_alpha = 1, den_width = 1, 
                   den_type = 1, den_leg = FALSE) {
  
  xdata <- data %>% 
    select_(x_data) %>% 
    unlist()
  
  h <- figure(title = fig_title, xlab = x_lab, ylab = y_lab, legend_location = NULL) %>%
    ly_hist(x = xdata, data = data, breaks = h_breaks, freq = h_freq, 
            include.lowest = h_incl_low, right = h_right, fill_color = h_fill_col) 
  
  if(add_density) {
    h <- ly_density(x = xdata, data = data, color = den_col, alpha = den_alpha,
               width = den_width, type = den_type, legend = den_leg)
  }
  
  h
}


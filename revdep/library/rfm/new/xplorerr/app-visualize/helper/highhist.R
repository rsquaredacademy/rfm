highist <- function(data, column, xlab = ' ', color = 'blue') {
  
  da <- data %>%
    select_(column) %>%
    pull(1) 
  
  h <- hchist(da, name = xlab)
  
  h %>%
    hc_colors(colors = color) %>%
    hc_yAxis(title = list(text = 'Frequency'))
  
}

highist(mtcars, 'mpg', xlab = 'Miles Per Gallon', color = 'red')

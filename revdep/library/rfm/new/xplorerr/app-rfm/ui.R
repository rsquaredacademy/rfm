library(shiny)
library(shinyBS)
library(shinythemes)
library(shinycssloaders)
library(magrittr)
library(shinycssloaders)

shinyUI(

    navbarPage(HTML("rfm"), id = 'mainpage',

    # source('ui/ui_welcome.R', local = TRUE)[[1]],	
    source('ui/ui_data.R', local = TRUE)[[1]],
    source('ui/ui_analyze.R', local = TRUE)[[1]],
    source('ui/ui_exit_button.R', local = TRUE)[[1]]
))

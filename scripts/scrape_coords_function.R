# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# function: scrape coordinates -------------------------------------------------

scrape_coord <- function(url){
  
#read page
  
  page <- read_html(url)
  
#scrape longitude
  
  longitude <- page %>%
    html_node(".longitude") %>%
    html_text()
  
#scrape latitude
  
  latitude <- page %>%
    html_node(".latitude") %>%
    html_text()
  
#make data
  
  tibble(
    long = longitude,
    lat = latitude,
    origin = url
   )
  
}
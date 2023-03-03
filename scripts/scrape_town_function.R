# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# function: scrape origin ------------------------------------------------------

scrape_town <- function(url){

#read page

page <- read_html(url)

#scrape artist name

artist <- page %>%
  html_node(".infobox-above div") %>%
  html_text()

#scrape origin town

origin <- page %>%
  html_nodes(".infobox-data") %>%
  html_node("a") %>%
  html_attr("href") %>%
  str_replace(".", "https://en.wikipedia.org/")

#make data

tibble(
  artistName = artist,
  origin = origin)

}
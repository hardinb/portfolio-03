# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(glue)

# list of urls to be scraped ---------------------------------------------------

root <- "https://en.wikipedia.org/wiki/"
artists <- c("The_Mountain_Goats",
             "Wednesday_(American_band)",
             "Japanese_Breakfast",
             "The_Beatles",
             "Cake_(band)",
             "Phoebe_Bridgers",
             "St._Vincent_(musician)")
urls <- glue("{root}{artists}")

# making a dataframe -----------------------------------------------------------

artist_towns <- map_dfr(urls, scrape_town)

# scraping coordinates from towns ----------------------------------------------

artist_towns <- artist_towns %>%
  filter(!is.na(origin)) %>%
  filter(!grepl("/ttp", origin)) %>%
  filter(!grepl("1", origin))

towns <- artist_towns$origin

origin_coords <- map_dfr(towns, scrape_coord)

# saving dataframes ------------------------------------------------------------

write_csv(artist_towns, file = "data/artist_towns.csv")

write_csv(origin_coords, file = "data/origin_coords.csv")

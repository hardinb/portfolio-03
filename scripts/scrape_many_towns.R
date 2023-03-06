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
             "St._Vincent_(musician)",
             "Sleater-Kinney",
             "R.E.M.",
             "AJJ_(band)",
             '"Weird_Al"_Yankovic',
             "Tom_Petty",
             "Okkervil_River",
             "Neutral_Milk_Hotel",
             "Soccer_Mommy",
             "Snail_Mail_(musician)",
             "The_Weakerthans",
             "Bob_Dylan",
             "Johann_Sebastian_Bach",
             "Big_Thief",
             "Pat_The_Bunny",
             "Arcade_Fire",
             "The_Cure",
             "The_Flaming_Lips",
             "The_Beths",
             "The_Replacements_(band)",
             "Fleet_Foxes",
             "TV_on_the_Radio",
             "Sufjan_Stevens",
             "Superorganism_(band)",
             "Propagandhi",
             "Radiator_Hospital",
             "The_Sugarcubes",
             "Ludwig_van_Beethoven",
             "Mitski",
             "Tom_Petty_and_the_Heartbreakers",
             "Jeff_Rosenstock",
             "Land_of_Talk",
             "Nina_Simone",
             "Vetiver_(band)",
             "Lucy_Dacus",
             "Punch_Brothers",
             "The_Notorious_B.I.G.",
             "Electric_Light_Orchestra",
             "Slowdive",
             "The_Decemberists",
             "Simon_%26_Garfunkel",
             "The_Shins",
             "Bright_Eyes_(band)",
             "Cocteau_Twins",
             "The_Cranberries",
             "The_Microphones",
             "Broken_Social_Scene",
             "Foo_Fighters",
             "Frank_Zappa",
             "Grateful_Dead",
             "Gustav_Mahler",
             "Tigran_Hamasyan")
urls <- glue("{root}{artists}")

# making a dataframe -----------------------------------------------------------

artist_towns <- map_dfr(urls, scrape_town)

# scraping coordinates from towns ----------------------------------------------

artist_towns <- artist_towns %>%
  filter(!is.na(origin)) %>%
  filter(!grepl("/ttp", origin)) %>%
  filter(!grepl("cite_note", origin)) %>%
  filter(!grepl("index.php", origin)) %>%
  filter(!grepl("/Awards", origin))

towns <- artist_towns$origin

origin_coords <- map_dfr(towns, scrape_coord)

# saving dataframes ------------------------------------------------------------

write_csv(artist_towns, file = "data/artist_towns.csv")

write_csv(origin_coords, file = "data/origin_coords.csv")

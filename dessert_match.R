#Loading libraries

library(tidyverse)
library(here)
library(janitor)
library(rvest)



# Check if that data folder exists and creates it if not
dir.create("data", showWarnings = FALSE)

# Read the webpage code
webpage <- read_html("https://www.eatthis.com/iconic-desserts-united-states/")

# Extract the desserts listing
dessert_elements<- html_elements(webpage, "h2")

dessert_listing <- dessert_elements %>% 
  html_text2() %>%             # extracting the text associated with this type of element of the webpage
  as_tibble() %>%              # make it a data frame
  rename(dessert = value) %>%  # better name for the column
  head(.,-3) %>%               # 3 last ones were not desserts 
  rowid_to_column("rank") %>%  # adding a column using the row 
write_csv("data/iconic_desserts.csv") # save it as csv

my_fav_dessert <-c("cotton candy")

if(any(str_detect(dessert_listing, my_fav_dessert))) {
  print("yay cotton candy")} else{
    print("no cotton candy")}


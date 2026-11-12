

library(tidyverse)
library(sf)
library(readxl)

url <- "https://orca.casa.ucl.ac.uk/~jreades/data/20260619-London-listings.csv.gz"


bnb <- readr::read_csv(
  url,
  show_col_types = FALSE
)

View(df)
names(bnb)
glimpse(bnb)

#read rows
gii_coloums <- read_csv(
  "/fsds-group-work/data/20260619-London-listings.csv",
  col_names = FALSE
)
print(bnb_rows[1:15, 1:8])


bnb_clean <- bnb %>%
  select(
    id, host_id,
    neighbourhood_cleansed,
    latitude, longitude,
    room_type, property_type,
    accommodates, price,
    availability_90, availability_365,
    estimated_occupancy_l365d,
    estimated_revenue_l365d,
    number_of_reviews_ltm,
    calculated_host_listings_count
  ) %>%
  mutate(
    price = readr::parse_number(price),
    entire_home = room_type == "Entire home/apt",
    multi_listing_host = calculated_host_listings_count > 1
  )

glimpse(bnb_clean)

View(bnb_clean)

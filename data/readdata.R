
library(tidyverse)
library(sf)
library(readxl)

# 1. Load data
url <- "https://orca.casa.ucl.ac.uk/~jreades/data/20260619-London-listings.csv.gz"

bnb <- readr::read_csv(
  url,
  show_col_types = FALSE
)

# 2. Inspect original dataset
View(bnb)
names(bnb)
glimpse(bnb)

# View first 15 rows and 8 columns
print(bnb[1:15, 1:8])

# 3. Select relevant variables and clean data
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

# 4. Inspect cleaned dataset
glimpse(bnb_clean)
View(bnb_clean)

# 5. Check data quality
dim(bnb_clean)
sum(duplicated(bnb_clean$id))

bnb_clean %>%
  summarise(across(everything(), ~sum(is.na(.x))))



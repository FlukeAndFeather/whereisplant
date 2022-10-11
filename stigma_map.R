library(ggmap)
library(sf)
library(tidyverse)

sampling_sites <- read_csv("data/Nemophila Stigma Collection- Nemophila menziesii.xlsx.csv") %>%
  st_as_sf(wkt = "WKT",
           crs = "+proj=longlat +datum=WGS84")

ggplot() +
  geom_sf(data = sampling_sites)

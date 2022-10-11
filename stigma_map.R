library(ggmap)
library(sf)
library(tidyverse)
ggmap_proj4 <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +k=1 +units=m +nadgrids=@null +wktext +no_defs +type=crs"

# Read data and convert to a spatially-aware data type (sf)
sampling_sites <- read_csv("data/Nemophila Stigma Collection- Nemophila menziesii.xlsx.csv") %>%
  st_as_sf(wkt = "WKT",
           crs = "+proj=longlat +datum=WGS84")

# Download a basemap using the bounding box of the sampling sites (plus a
# buffer of 5%)
basemap_bbox <- st_bbox(sampling_sites)
basemap_bbox_xrng <- basemap_bbox["xmax"] - basemap_bbox["xmin"]
basemap_bbox_yrng <- basemap_bbox["ymax"] - basemap_bbox["ymin"]
basemap_bbox["xmin"] <- basemap_bbox["xmin"] - basemap_bbox_xrng * 0.05
basemap_bbox["xmax"] <- basemap_bbox["xmax"] + basemap_bbox_xrng * 0.05
basemap_bbox["ymin"] <- basemap_bbox["ymin"] - basemap_bbox_yrng * 0.05
basemap_bbox["ymax"] <- basemap_bbox["ymax"] + basemap_bbox_yrng * 0.05
names(basemap_bbox) <- c("left", "bottom", "right", "top")
ca_basemap <- get_map(location = basemap_bbox,
                      source = "osm")

# Make the map
# Ignore the "Coordinate system already present" message
ggmap(ca_basemap) +
  geom_sf(data = sampling_sites, inherit.aes = FALSE) +
  theme(axis.title = element_blank())

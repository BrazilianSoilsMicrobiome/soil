# Code taken from 
# https://melaniewalsh.github.io/Intro-Cultural-Analytics/07-Mapping/01-Mapping.html
# and 
# https://melaniewalsh.github.io/Intro-Cultural-Analytics/07-Mapping/03-Publish-Your-Map.html
# 
# Improve your map
# https://rpubs.com/Tanishq_Porwal/interactivemap
# https://stackoverflow.com/questions/37798690/search-button-for-leaflet-r-map
# 
# install.packages("htmlwidgets") # to save map as HTML page
# install.packages("leaflet")
#
library(htmlwidgets)
library(leaflet)

# Load sample data
soil_samples_df <- read.delim(file = "../Samples/Sample_metadata.txt")

# First Map example
# m <- leaflet() %>%
#   addTiles() %>%  # Add default OpenStreetMap map tiles
#   addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
# m  # Print the map

# Without pipes
# m <- leaflet()
# m <- addTiles(m)
# m <- addMarkers(m, lng=174.768, lat=-36.852, popup="The birthplace of R")
# m 

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=soil_samples_df$longitude, lat=soil_samples_df$latitude, popup=soil_samples_df$BMP_ID)
m  # Print the map


saveWidget(m, file="../soils_map.html")

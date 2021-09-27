# Code taken from 
# https://melaniewalsh.github.io/Intro-Cultural-Analytics/07-Mapping/01-Mapping.html
# and 
# install.packages("leaflet")
library(leaflet)


m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map


# m <- leaflet()
# m <- addTiles(m)
# m <- addMarkers(m, lng=174.768, lat=-36.852, popup="The birthplace of R")
# m 

# install.packages("htmlwidgets")
library(htmlwidgets)
saveWidget(m, file="m.html")

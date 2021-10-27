devtools::install_github("jcheng5/d3scatter")
library(d3scatter)
library(leaflet)
# Inspiration
# https://github.com/matt-dray/rostrum-blog/blob/master/content/post/2018-09-12-crosstalk-memes.Rmd
# https://matt-dray.github.io/earl18-crosstalk/04_leaflet-flexdash-dt-crosstalk.html
# https://github.com/rstudio/crosstalk
# https://rstudio.github.io/crosstalk/using.html
# https://github.com/jcheng5/d3scatter

setwd(dir = "G:/My Drive/BrazilianSoilsMicrobiome/github_page/soil/")
soil_samples_df <- read.delim(file = "Samples/Sample_metadata.txt")

# feed shared object
data_ct <- crosstalk::SharedData$new(soil_samples_df[,c(1,2,3,5,6,7,11,12,13)])

# generate filterable table
DT::datatable(data_ct)

# d3scatter(iris, ~Petal.Length, ~Petal.Width, ~Species)
d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, ~Biome)

crosstalk::bscols(
  widths = c(6,6,8), device = "xs",
  
  leaflet(data_ct, width = "100%", height = 300) %>%
    addTiles() %>%
    addMarkers(),
  
  d3scatter::d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, ~Biome,
                       width = "100%", height = 300),
  
  DT::datatable(data_ct,rownames = FALSE, filter = 'top',
                width = 600, height = 600)
)

# 
# bscols(
#   leaflet(data_ct, width = "100%", height = 300) %>%
#     addTiles() %>%
#     addMarkers(),
#   d3scatter(shared_quakes, ~depth, ~mag, width = "100%", height = 300)
# )

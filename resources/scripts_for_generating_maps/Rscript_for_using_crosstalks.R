#devtools::install_github("jcheng5/d3scatter")
library(d3scatter)
library(leaflet)
library(geobr)

# Inspiration
# https://github.com/matt-dray/rostrum-blog/blob/master/content/post/2018-09-12-crosstalk-memes.Rmd
# https://matt-dray.github.io/earl18-crosstalk/04_leaflet-flexdash-dt-crosstalk.html
# https://github.com/rstudio/crosstalk
# https://rstudio.github.io/crosstalk/using.html
# https://github.com/jcheng5/d3scatter

setwd(dir = "G:/My Drive/daniel.kumazawa@ufv.br 2021-11-23 05 56/BrazilianSoilsMicrobiome/github_page/soil/")

# generate filling data
# soil_samples_df <- read.delim(file = "Samples/New_samples.txt")
# 
# Average.precip <- abs(round(x = rnorm(n = 94, mean = 60, sd = 35),digits = 2))
# Alpha_div <- abs(round(x = rnorm(n = 94, mean = 1.5, sd = 3),digits = 2))
# Org.Matter <- round(x = rnorm(n = 94, mean = 8, sd = 4),digits = 2)
# 
# soil_samples_df$Average.precip <- Average.precip
# soil_samples_df$Alpha_div <- Alpha_div
# soil_samples_df$Org.Matter <- Org.Matter
# 
# write.table(x = soil_samples_df, file = "new_samps.txt", quote = F, col.names = NA, sep = "\t")

soil_samples_df<- read.delim(file = "Samples/new_samps_metadata.txt")

## REORDER
soil_samples_df <- soil_samples_df[c(1,11,22,33,43,54,65,76,87,
                                     c(2:10),c(12:21),c(23:32),
                                     c(34:42),c(44:53),c(55:64),
                                     c(66:75),c(77:86),c(88:92)),]

## Rounding
soil_samples_df$Org.Matter <- round(soil_samples_df$Org.Matter, digits = 2)

## Add colors column
soil_samples_df$colors <-  soil_samples_df$Biome %>%
  gsub(pattern = "BR_Savanas", replacement = "orange") %>%
  gsub(pattern = "Atlanctic_forest", replacement = "lightblue") %>%
  gsub(pattern = "Amazon", replacement = "darkgreen") %>%
  gsub(pattern = "Caatinga", replacement = "yellow") %>%
  gsub(pattern = "Pampa", replacement = "lightgreen")

colors_chosen <- c("#3e204f", "#5a4565", "#cec9d6", "#e2dbe9", "#bcaecc")

soil_samples_df$colors <-  soil_samples_df$Biome %>%
  gsub(pattern = "BR_Savanas", replacement = "#3e204f") %>%
  gsub(pattern = "Atlanctic_forest", replacement = "#5a4565") %>%
  gsub(pattern = "Amazon", replacement = "#cec9d6") %>%
  gsub(pattern = "Caatinga", replacement = "#e2dbe9") %>%
  gsub(pattern = "Pampa", replacement = "#bcaecc")

soil_samples_df$colors <- as.factor(soil_samples_df$colors)
soil_samples_df$Biome <- as.factor(soil_samples_df$Biome)

dim(soil_samples_df)
# feed shared object
#data_ct <- crosstalk::SharedData$new(soil_samples_df[,c(1,2,3,5,6,7,11,12,13)])
data_ct <- crosstalk::SharedData$new(soil_samples_df)


# generate filterable table
DT::datatable(data_ct)
library(plotly)
library(ggplot2)
# d3scatter(iris, ~Petal.Length, ~Petal.Width, ~Species)
test <- ggplot2::ggplot(data = data_ct, aes(Org.Matter,Alpha_div))
gg <- ggplot(data = data_ct, aes(x = Org.Matter, y = Alpha_div, col = Biome)) + 
  geom_point() +
  scale_color_manual(values = c("orange", "#008BBD", "darkgreen", "yellow", "lightgreen"))

ggplotly(gg)


test <- d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, color = ~colors)
test <- d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, color = as.factor(colors_chosen))
test <- d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, color = "red")
d3scatter(data = data_ct, x = ~Org.Matter, y = ~Alpha_div, color = ~Biome)

test$colors <- soil_samples_df$colors

inherits(x = try(col2rgb(colors_chosen)), what = "try-error")

test$x$color_spec$type <- "linear"
test$x$color_spec$values <- c("orange", "#008BBD", "darkgreen", "yellow", "lightgreen")
test$x$color_spec$values <- c("BR_Savanas" = "orange",
     "Atlanctic_forest" = "#008BBD",
     "Amazon" = "darkgreen",
     "Caatinga" = "yellow",
     "Pampa" = "brown")

test$x$data$color <- test$x$data$color %>%
  gsub(pattern = "BR_Savanas", replacement = "orange") %>%
  gsub(pattern = "Atlanctic_forest", replacement = "#008BBD") %>%
  gsub(pattern = "Amazon", replacement = "darkgreen") %>%
  gsub(pattern = "Caatinga", replacement = "yellow") %>%
  gsub(pattern = "Pampa", replacement = "lightgreen")

test$x$color <- test$x$color %>%
  gsub(pattern = "BR_Savanas", replacement = "orange") %>%
  gsub(pattern = "Atlanctic_forest", replacement = "#008BBD") %>%
  gsub(pattern = "Amazon", replacement = "darkgreen") %>%
  gsub(pattern = "Caatinga", replacement = "yellow") %>%
  gsub(pattern = "Pampa", replacement = "lightgreen")

test$x$color_spec$values <- test$x$color_spec$values %>%
  gsub(pattern = "BR_Savanas", replacement = "orange") %>%
  gsub(pattern = "Atlanctic_forest", replacement = "#008BBD") %>%
  gsub(pattern = "Amazon", replacement = "darkgreen") %>%
  gsub(pattern = "Caatinga", replacement = "yellow") %>%
  gsub(pattern = "Pampa", replacement = "lightgreen")


  

test <- d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, color = c("BR_Savanas" = "orange",
                                                             "Atlanctic_forest" = "#008BBD",
                                                             "Amazon" = "darkgreen",
                                                             "Caatinga" = "yellow",
                                                             "Pampa" = "brown")
          )
test$x$color %>%
  gsub(pattern = "BR_Savanas", replacement = "pink")

test$x$color <- test$x$color %>%
  gsub(pattern = "BR_Savanas", replacement = "pink")
  
  
temp <- c(5,7,6,8,2)
barplot(temp, col = c("darkgreen","yellow","orange","brown","gray","#008BBD", "#4A6FE3"))
barplot(temp, col = c("orange", "#008BBD", "darkgreen", "yellow", "lightgreen"))

# d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, ~Biome, 
#           colors = c("#023FA5","#7D87B9","#BEC1D4","#D6BCC0","#BB7784","#FFFFFF", "#4A6FE3"))


# Crosstalk with biomes and new data
colors = c("darkgreen","yellow","orange","brown","gray","#008BBD", "#4A6FE3")

#sf_object <- readRDS(file = "G:/My Drive/daniel.kumazawa@ufv.br 2021-11-23 05 56/BrazilianSoilsMicrobiome/download_data/biomes_2019_sf_bject.RDS")
sf_object <- read_biomes(year = 2019, simplified = TRUE, showProgress = TRUE)

# subset coastal systems
#sf_object_no_coastal_sys <- sf_object[!(sf_object$name_biome %in% "Sistema Costeiro"), ]

# Biome info
biome_sampling_site_info <- c(paste("Biome: Amazon Forest", "<br>", "Samples sites: 33"),
                              paste("Biome: Caatinga (Unique Brazilian Xerophyle System", "<br>", "Samples sites: 11"),
                              paste("Biome: Cerrado (Brazilian Savanas)", "<br>", "Samples sites: 28"),
                              paste("Biome: Actlantic Forest", "<br>", "Samples sites: 18"),
                              paste("Biome: Pampa", "<br>", "Samples sites: 2"),
                              paste("Biome: Pantanal (Wetlands)", "<br>", "Samples sites: 0"),
                              paste("Biome: Coastal System", "<br>", "Samples sites: 0"))

leaflet(data_ct, width = "100%", height = 300) %>%
  addPolygons(data = sf_object$geom, 
              color = colors, 
              stroke = FALSE, 
              popup = biome_sampling_site_info) %>%
  addTiles() %>%
  addCircles(color = "brown")

crosstalk::bscols(
  widths = c(6,6,8), device = "xs",
  
  leaflet(data_ct, width = "100%", height = 300) %>%
    addPolygons(data = sf_object$geom, 
                color = colors, 
                stroke = FALSE, 
                popup = biome_sampling_site_info) %>%
    addTiles() %>%
    addCircles(color = "brown"),
  
  d3scatter::d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, ~Biome,
                       width = "100%", height = 300),
  
  DT::datatable(data_ct,rownames = FALSE, filter = 'none',
                width = 600, height = 600)
)

# Latest Crosstalk
# crosstalk::bscols(
#   widths = c(6,6,8), device = "xs",
#   
#   leaflet(data_ct, width = "100%", height = 300) %>%
#     addTiles() %>%
#     addCircles(),
#   
#   d3scatter::d3scatter(data = data_ct, ~Org.Matter, ~Alpha_div, ~Biome,
#                        width = "100%", height = 300),
#   
#   DT::datatable(data_ct,rownames = FALSE, filter = 'top',
#                 width = 600, height = 600)
# )

# Small crosstalk test
# bscols(
#   leaflet(data_ct, width = "100%", height = 300) %>%
#     addTiles() %>%
#     addMarkers(),
#   d3scatter(shared_quakes, ~depth, ~mag, width = "100%", height = 300)
# )

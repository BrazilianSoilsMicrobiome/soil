# Interesting plots

library(maps)
library(magrittr)
library(rbokeh)
# Interesting plots
# https://hafen.github.io/rbokeh/articles/rbokeh.html
data(world.cities)
#install.packages("rbokeh")
setwd(dir = "G:/My Drive/daniel.kumazawa@ufv.br 2021-11-23 05 56/BrazilianSoilsMicrobiome/github_page/soil/")
soil_samples_df <- read.delim(file = "Samples/New_samples.txt")


figure(width = 800, height = 450, padding_factor = 0) %>%
  ly_map(database = "world",regions = "Brazil", col = "gray") %>%
  ly_points(Longitude, Latitude, data = soil_samples_df, size = 5)

#Data manipulation for upsetjs
library(upsetjs)

#load data
data <- read.delim(file = "Samples/mock_all_data.txt")
#get taxas and biome
data_taxa <- data[,c(2:21, 26)]

aggreg_data <- aggregate(data_taxa[,1], list(data_taxa$Biome), sum)
colnames(aggreg_data)[1] <- "Biome"
colnames(aggreg_data)[2] <- "taxa1"

for(i in 2:20){
  x = aggregate(data_taxa[,i], list(data_taxa$Biome), sum)
  column = paste0("taxa", i)
  colnames(x)[2] = column
  aggreg_data <- cbind(aggreg_data, x[column])
}

#making mock data, in real data, chage 2000 to 1 or any threshold that represents a significant amount of a taxa in a sample
biome <- aggreg_data[,1]
aggreg_data[!aggreg_data >= 2000] <- 1
aggreg_data[!aggreg_data < 2000] <- 0
rownames(aggreg_data)<- biome
aggreg_data <- aggreg_data[,-1]
aggreg_data <- t(aggreg_data)
aggreg_data <- as.data.frame(aggreg_data)

#finally, upset plotting
upsetjs() %>%
  fromDataFrame(aggreg_data) %>%
  generateIntersections(min = 2, max = NULL, empty = F, order.by = "cardinality",
                        limit = NULL) %>%
  interactiveChart()

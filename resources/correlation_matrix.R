#Reducing and sectorizing data
library(qtlcharts)

#our data
data <- read.delim("Samples/mock_all_data.txt")

#only taxa, must be edited when using real data
data_taxa <- data[, c(1:21)]

#name rows as ID
rownames(data_taxa) <- data_taxa$Sample_ID
data_taxa_clean <- data_taxa[, c(2:ncol(data_taxa))]

#coercing into a matrix
matrix_taxa <- as.matrix(data_taxa_clean)

#get biomes vector
biomes <- factor(data$Biome)

#correlation and ordering
spearman <- cor(data_taxa_clean, use="pairwise.complete.obs", method = "spearman")
ord <- hclust(as.dist(-spearman))$order

#setting postions for sectorizing
if(length(ord)%%2 ==0)
  {
  first_half <- length(ord)/2
  second_half <- (length(ord)/2)+1
  end <- length(ord)
} else {
  first_half <- length(round(ord/2))
  second_half <- (length(round(ord/2))+1)
  end <- length(ord)
  }

#ploting first quarter
corrplot1 <- iplotCorr(data_taxa_clean[,ord],
                      biomes,
                      corr=spearman[ord[c(1:first_half)],ord[c(1:first_half)]],
                      chartOpts=list(scatcolors= RColorBrewer::brewer.pal(6,"Set2"),
                                     height=600))

#ploting second quarter
corrplot2 <- iplotCorr(data_taxa_clean[,ord],
                       biomes,
                       corr=spearman[ord[c(1:first_half)],ord[c(second_half:end)]],
                       chartOpts=list(scatcolors= RColorBrewer::brewer.pal(6,"Set2"),
                                      height=600))

#ploting third quarter
corrplot3 <- iplotCorr(data_taxa_clean[,ord],
                       biomes,
                       corr=spearman[ord[c(second_half:end)],ord[c(1:first_half)]],
                       chartOpts=list(scatcolors= RColorBrewer::brewer.pal(6,"Set2"),
                                      height=600))


#ploting fourth quarter
corrplot4 <- iplotCorr(data_taxa_clean[,ord],
                       biomes,
                       corr=spearman[ord[c(second_half:end)],ord[c(second_half:end)]],
                       chartOpts=list(scatcolors= RColorBrewer::brewer.pal(6,"Set2"),
                                      height=600))

#setScreenSize("large")

#positive quarters
corrplot1
corrplot4
#negative quarters
corrplot2
corrplot3

library(reshape)

mock_samples <- read.delim("C:/Users/your_directory/Samples/mock_taxa_samples.txt")
melted_mock<-melt(mock_samples)
reduced_mock <- melted_mock[melted_mock$value>0,]
write.table(reduced_mock, file = "reduced_taxa_mock.txt", sep="\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
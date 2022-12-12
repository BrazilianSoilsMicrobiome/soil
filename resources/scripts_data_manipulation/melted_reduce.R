library(reshape)

mock_samples <- read.delim("C:/Users/your_directory/mock_samples.txt")
melted_mock<-melt(mock_samples)
reduced_mock <- melted_mock[apply(melted_mock,1, function(x) all(x!= 0)),]
write.table(reduced_mock, file = "reduced_mock.txt", sep="\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
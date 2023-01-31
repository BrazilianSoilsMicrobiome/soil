library(knitr)
library(rmarkdown)

#Com os dados reais, vai precisar converter o tipo de dado para list

parameters <- list(list(taxa = "taxa1", name = "Some namus"), list(taxa = "taxa2", name = "Other namus"))
for (i in 1:length(parameters)) {
  render("./template.Rmd", output_file = paste0("taxa", i, ".html"), params = parameters[[i]])
}


#setwd(dir = "G:/My Drive/BrazilianSoilsMicrobiome/github_page/soil/")

rmarkdown::render(input = "index.Rmd", output_format = "html_document",
                  output_file = "index.html")

new_page <- read.delim(file = "index.html", header = F)
row.names(new_page) <- 4:(nrow(new_page)+3)

layout_lines <- data.frame(col1 = c("---", "layout: default", "---"))
page_with_layout <- c(layout_lines[,1], new_page[,1])


write.table(x = page_with_layout, file = "index.html",
            quote = F,
            row.names = F,
            col.names = F)
  
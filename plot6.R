if(!file.exists("summarySCC_PM25.rds") & file.exists("Source_Classification_Code.rds") ){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "./data.zip")
        unzip("./data.zip")
        
}


library(ggplot2)
data <- readRDS("./summarySCC_PM25.rds")
src <- readRDS("./Source_Classification_Code.rds")


final <- merge(data, src, by= "SCC")

vec <- grep("vehicle", final$SCC.Level.Two, ignore.case = T)
final <- final[vec, ]

final <- final[final$fips == "24510" | final$fips == "06037",]


Tot <- aggregate(Emissions ~ year + fips, final, sum)

g <- ggplot(Tot, aes(as.factor(year), Emissions))

Tot$fips[Tot$fips == "06037"] <- "Los Angeles County" 
Tot$fips[Tot$fips == "24510"] <- "Baltimore City" 

g + geom_col() + xlab("year") + 
        ggtitle("Total Emissions From Motor Sources") +
        facet_wrap(.~Tot$fips)


ggsave("plot6.png")
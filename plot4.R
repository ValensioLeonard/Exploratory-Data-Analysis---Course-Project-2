## Check if the file exists on the working directory
if(!file.exists("summarySCC_PM25.rds") & file.exists("Source_Classification_Code.rds")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "./data.zip")
        unzip("./data.zip")
        
}

## Load the ggplot2 package
library(ggplot2)

## Read both data and source from the unzipped file
data <- readRDS("./summarySCC_PM25.rds")
src <- readRDS("./Source_Classification_Code.rds")

## Merge the data based on SCC code on both sets
final <- merge(data, src, by= "SCC")

## Search for "coal" in the merged data under Short.Name column
coal <- grep("coal", final$Short.Name, ignore.case = T)

##  Subset the data, and take only the data with coal
final <- final[coal, ]

## Using aggregate function, sum up the emissions based on year 
Tot <- aggregate(Emissions ~ year, final, sum)

## assign the ggplot function to variable g, with year as the X value and
## Emissions as the Y value
g <- ggplot(Tot, aes(year, Emissions))

## Plot g with geom_col as the plotting method
g + geom_col() + xlab("year") + ggtitle("Total Emissions From Coal Sources in Baltimore City")

## Save the plot into png format
ggsave("plot4.png")



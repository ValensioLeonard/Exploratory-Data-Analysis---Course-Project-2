## Check if the file exists on the working directory
if(!file.exists("summarySCC_PM25.rds") & file.exists("Source_Classification_Code.rds")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "./data.zip")
        unzip("./data.zip")
        
}

## Read the summary data
data <- readRDS("./summarySCC_PM25.rds")

## subset the Baltimore City data
data <- data[data$fips == "24510",]
rm(data)

## Use the aggregate function to sum up 
## the emissions based on year and type
Tot <- aggregate(Emissions ~ year + type, data, sum)

## assign the ggplot function to variable g, with year as the X value and
## Emissions as the Y value, and separate the plot color by type
g <- ggplot(Tot, aes(year,Emissions, color = type))

## Call the g and add line as the graphic method
g + geom_line() + ggtitle("Total Emissions in Baltimore City")

## Save the plot into png format
ggsave("plot3.png")

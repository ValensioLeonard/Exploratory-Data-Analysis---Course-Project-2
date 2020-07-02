## Check if the file exists on the working directory
if(!file.exists("summarySCC_PM25.rds") & file.exists("Source_Classification_Code.rds")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "./data.zip")
        unzip("./data.zip")
     
}

## Read the summary data
data <- readRDS("./summarySCC_PM25.rds")

## Use the aggregate function to sum up the emissions based on year
Tot <- aggregate(Emissions ~ year, data, sum)

## Use the base plot function barplot, 
## to plot the emissions based on year
barplot(Tot$Emissions, 
        names.arg = Tot$year, 
        xlab = "Year", 
        ylab = "Emissions Level", 
        main = "PM 2.5 Level Throughout the years")


## Save the file to png, and deactivate the graphic device
dev.copy(png, file="plot1.png")
dev.off()
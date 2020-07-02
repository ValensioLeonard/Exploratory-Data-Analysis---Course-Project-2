# Exploratory-Data-Analysis Course-Project-2

## Data
the data for this assignment are available from the course web site as a single zip file:

[Data for Peer Assessment](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data `summarySCC_PM25.rds` : This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.


```
    fips      SCC Pollutant Emissions  type year
4  09001 10100401  PM25-PRI    15.714 POINT 1999
8  09001 10100404  PM25-PRI   234.178 POINT 1999
12 09001 10100501  PM25-PRI     0.128 POINT 1999
16 09001 10200401  PM25-PRI     2.036 POINT 1999
20 09001 10200504  PM25-PRI     0.388 POINT 1999
24 09001 10200602  PM25-PRI     1.490 POINT 1999
``` 

- `fips` : A five-digit number (represented as a string) indicating the U.S. county
- `SCC` : The name of the source as indicated by a digit string (see source code classification table)
- `Pollutant` : A string indicating the pollutant
- `Emissions` : Amount of PM2.5 emitted, in tons
- `type` : The type of source (point, non-point, on-road, or non-road)
- `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.


You can read each of the two files using the readRDS() function in R. For example, reading in each file can be done with the following code:

```
This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).


## Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

Questions
You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (`fips == "24510"`) from 1999 to 2008? Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the `type` variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (`fips == "06037"`). Which city has seen greater changes over time in motor vehicle emissions?

## Preparing the data
First and foremost, you should prepare the datasets in your working directory, all the Rscripts are equipped with starting code to check whether you have the datasets on your working directory. 
The code appears as follows,

```
if(!file.exists("summarySCC_PM25.rds") & file.exists("Source_Classification_Code.rds")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url, destfile = "./data.zip")
        unzip("./data.zip")
     
}
```
If statement will check whether you have the datasets in your working directory, if one of the required data isn't there, it will download the datasets automatically.

## Reading the data
After the datasets are ready, you can read it into R using these following lines.
```
data <- readRDS("./summarySCC_PM25.rds")
src <- readRDS("./Source_Classification_Code.rds")
```

## Question 1
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

First, use `aggregate` function to `sum` Emissions based on `year`, on `data`, assign the results to `Tot`

```
data <- readRDS("./summarySCC_PM25.rds")
Tot <- aggregate(Emissions ~ year, data, sum)
```

Second, use the base plotting system `barplot`, since we will be constructing barplot, the data needed will only be the 
Emissions column from Tot data, add names arguments based on year, and add axis title and main title

```
barplot(Tot$Emissions, 
        names.arg = Tot$year, 
        xlab = "Year", 
        ylab = "Emissions Level", 
        main = "PM 2.5 Level Throughout the years")
```

Lastly, Save the plot results into png format using `dev.copy`, and close the graphic system.

```
dev.copy(png, file="plot1.png")
dev.off()
```
![Plot1 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot1.png)

As we can see from the plot, the emissions level did decrease from 1999 to 2008, based on our data that we analyze.

## Question 2
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (`fips == "24510"`) from 1999 to 2008? Use the base plotting system to make a plot answering this question.

To answer this question, steps that we take will mostly be the same, expect we must first subset the data according to the fips number for Baltimore City

```
data <- readRDS("./summarySCC_PM25.rds")
data <- data[data$fips == "24510",]
```

After this, we shall use `aggregate` function to `sum` Emissions based on `year`, on `data`, assign the results to `Tot` just like previous question.

`Tot <- aggregate(Emissions ~ year, data, sum)`

Lastly, call the barplot function to plot the emissions, and save the plot before closing the plotting devices
```
barplot(Tot$Emissions, 
        names.arg = Tot$year, 
        xlab = "Year", 
        ylab = "Emissions Level", 
        main = "PM 2.5 in Baltimore City")
```


![Plot2 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot2.png)

Based on the graphs, there was a decrease in emissions level from 1999 to 2002, but followed with an increase in 2005, and closed with a decrease in 2008

## Question 3
Of the four types of sources indicated by the `type` variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

To answer this question, first read the data and subset it based on fips for Baltimore City, since we'll be needing ggplot2 in this question, don't forget to load it into R.

```
library(ggplot2)
data <- readRDS("./summarySCC_PM25.rds")
data <- data[data$fips == "24510",]
```

Next, use `aggregate` function to `sum` Emissions based on `year` and `type` , on `data`, assign the results to `Tot`.
```
Tot <- aggregate(Emissions ~ year + type, data, sum)
```

Prepare the Plot by calling `ggplot` function, assign Tot as the data and `year`,`Emissions` for the `aes` arguments, also add `color=type` to distinguish the plot type by color. Assign the function to variable `g`.
`g <- ggplot(Tot, aes(year,Emissions, color = type))`

Call the `geom_line` function to plot `g` into graphic device using line. Add the tittle using `ggtitle` function, and save the plot using `ggsave` function.
```
g + geom_line() + ggtitle("Total Emissions in Baltimore City")
ggsave("plot3.png")
```
![Plot3 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot3.png)


## Question 4
Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

To answer this question, read both data and merged them by `SCC` code.
```
data <- readRDS("./summarySCC_PM25.rds")
src <- readRDS("./Source_Classification_Code.rds")
final <- merge(data, src, by= "SCC")
```
After that, search for "coal" in `src` data under `Short.Name` column, `grep` function will return the number of row that meet these arguments.
Subset the `final` data using this information. 
```
coal <- grep("coal", final$Short.Name, ignore.case = T)
final <- final[coal, ]
```
Lastly, plotting the data will use these lines just like previous question.
```
Tot <- aggregate(Emissions ~ year, final, sum)
g <- ggplot(Tot, aes(year, Emissions))
g + geom_col() + xlab("year") + ggtitle("Total Emissions From Coal Sources in Baltimore City")
```
![Plot4 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot4.png)

## Question 5
How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

This question will be using quite similar method from previous questions. After reading the data and merging it,
search for vehicle using `grep` function under `SCC.Level.Two`. Assign the `final` data using this information
```
vec <- grep("vehicle", final$SCC.Level.Two, ignore.case = T)
final <- final[vec, ]

```
Call the ggplot function and turn year into factor using `as.factor()` function
```
g <- ggplot(Tot, aes(as.factor(year), Emissions))
g + geom_col() + xlab("year") + ggtitle("Total Emissions From Motor Sources in Baltimore City")
```
![Plot5 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot5.png)

## Question 6
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (`fips == "06037"`). Which city has seen greater changes over time in motor vehicle emissions?

Using the same method to retrieve the vehicle row, subset the data based on that information.
Also subset the data based o```n both L.A. and Baltimore City fips.
```
vec <- grep("vehicle", final$SCC.Level.Two, ignore.case = T)
final <- final[vec, ]
final <- final[final$fips == "24510" | final$fips == "06037",]
```
Sum up the emissions using aggregate function and plot it using the ggplot just like before. 
```
Tot <- aggregate(Emissions ~ year + fips, final, sum)

g <- ggplot(Tot, aes(as.factor(year), Emissions))

## Change the category into names of the city
Tot$fips[Tot$fips == "06037"] <- "Los Angeles County" 
Tot$fips[Tot$fips == "24510"] <- "Baltimore City"  

g + geom_col() + xlab("year") + 
        ggtitle("Total Emissions From Motor Sources") +
        facet_wrap(.~Tot$fips)
```
![Plot6 Results](https://github.com/ValensioLeonard/Exploratory-Data-Analysis---Course-Project-2/blob/master/plot6.png)


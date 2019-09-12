## This first line will likely take a few seconds. Be patient!
if( !exists("dfNEI") ) # read only if not already exists
{
  dfNEI <- readRDS("./summarySCC_PM25.rds")
}
if( !exists("dfSCC") ) # read only if not already exists
{
  dfSCC <- readRDS("./Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

dfNEIBaltimore <- dfNEI[dfNEI$fips=="24510", ]

# Aggregate by sum the total emissions by year
aggEmissionsYears <- aggregate(Emissions ~ year + type, dfNEIBaltimore, sum)

## load library ggplot
library(ggplot2)

png("plot3.png",width=480,height=480,units="px")

## create for each type a line
g <- ggplot((aggEmissionsYears), aes(year, Emissions, color = type))
g <- g + geom_line() +
  labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
  ggtitle("Total Emissions by Type in Baltimore City, Maryland per year")
print(g)

dev.off() # close device
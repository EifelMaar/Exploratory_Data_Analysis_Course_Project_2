## This first line will likely take a few seconds. Be patient!
if( !exists("dfNEI") ) # read only if not already exists
{
  dfNEI <- readRDS("./summarySCC_PM25.rds")
}
if( !exists("dfSCC") ) # read only if not already exists
{
  dfSCC <- readRDS("./Source_Classification_Code.rds")
}

## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
## fips == "24510" => Balitmore
## California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


## Gather the subset of the NEI data for city and searching for ON-ROAD type in NEI
subsetNEI <- NEI[(dfNEI$fips=="24510"|dfNEI$fips=="06037") & dfNEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=800, height=480)

g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity",fill="grey",width=0.75)  +
  labs(title = "Motor Vehicle Source Emissions in Baltimore & LA", x = "Year", y = "Total Emissions (Tons)")
print(g)

dev.off() # close device

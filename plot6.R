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
aggEmissionsYears <- ddply(NEI[dfNEI$fips == "24510" & NEI$type == "ON-ROAD",], .(type, year), summarize, TotalEmissions = sum(Emissions))

png("plot6.png", width=840, height=480)
g <- ggplot(aggEmissionsYears, aes(factor(year), TotalEmissions))
g <- g + geom_bar(stat="identity",fill="grey",width=0.75) +
  labs(title = "Total Emissions from Motor Vehicles in Baltimore City", x = "Year", y = "Total Emissions (Tons)")
print(g)

dev.off() #close device
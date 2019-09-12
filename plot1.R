## This first line will likely take a few seconds. Be patient!
if( !exists("dfNEI") ) # read only if not already exists
{
  dfNEI <- readRDS("./summarySCC_PM25.rds")
}
if( !exists("dfSCC") ) # read only if not already exists
{
  dfSCC <- readRDS("./Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

# Aggregate by sum the total emissions by year
aggEmissionsYears <- aggregate(Emissions ~ year, dfNEI, sum)

png("plot1.png",width=480,height=480,units="px")

barplot(
  (aggEmissionsYears$Emissions)*10^-6,
  names.arg=aggEmissionsYears$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Mega Tons)",
  main="Total PM2.5 Emissions in the United States per year"
)

dev.off()
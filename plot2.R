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
aggEmissionsYears <- aggregate(Emissions ~ year, dfNEIBaltimore, sum)

png("plot2.png",width=480,height=480,units="px")

barplot(
  (aggEmissionsYears$Emissions)*10^-3,
  names.arg=aggEmissionsYears$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Kilo Tons)",
  main="Total PM2.5 Emissions in Baltimore City, Maryland per year"
)

dev.off()
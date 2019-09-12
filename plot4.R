## This first line will likely take a few seconds. Be patient!
if( !exists("dfNEI") ) # read only if not already exists
{
  dfNEI <- readRDS("./summarySCC_PM25.rds")
}
if( !exists("dfSCC") ) # read only if not already exists
{
  dfSCC <- readRDS("./Source_Classification_Code.rds")
}

## Across the United States, how have emissions from coal combustion-related sources changed from 1999???2008?

# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", dfSCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", dfSCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- dfSCC[coalCombustion,]$SCC
combustionNEI <- dfNEI[dfNEI$SCC %in% combustionSCC,]


## load library ggplot
library(ggplot2)

png("plot4.png",width=480,height=480,units="px")

## create for each type a line
g <- ggplot(combustionNEI,aes(factor(year),Emissions*1e-3))
g <- g + geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y="Total PM2.5 Emission (Kilo Tons)") + 
  labs(title="PM2.5 Coal Combustion Source Emissions Across US per year")
print(g)

dev.off() # close device


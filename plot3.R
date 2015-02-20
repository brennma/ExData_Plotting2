###############  Question 3 ####################################
#   Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#   which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#   Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
################################################################

# Load the data into memory.
   NEI <- readRDS("summarySCC_PM25.rds")
   SCC <- readRDS("Source_Classification_Code.rds")

# load the dplyr package to summarize the data.
  library("dplyr")
# load the ggplot2 package to visualize the data.
  library("ggplot2")


## Filter SCC$Data.Category in ("POINT","NONPOINT","ON-ROAD","NON-ROAD") and NEI$fips == "24510"
  baltimore <- NEI[NEI$fips == "24510",]

  plot3Data <- summarize(group_by(baltimore, type, year), Emissions = sum(Emissions))
  plot3Data$typeF <- factor(plot3Data$type)

## Open the png device with a size of 480px by 480px
  png(file = "plot3.png",height = 480, width = 480)

## Create the 4 quadrant of plots of Global Active Power, voltage, Sub metering for meters 1,2,3 and global reactive power
  chart4 <-ggplot(aes(x=year, y=Emissions), data = plot3Data) + geom_line(aes(colours = type)) 
  chart4 <- chart4 + facet_wrap(facets = "typeF")+ labs(title = "Baltimore City, MD Emissions Trend by Type")
  chart4 <- chart4 + labs(x = "Year", y = "PM2.5 Emission")
  print(chart4)
## Close the png device to write the file.
dev.off()





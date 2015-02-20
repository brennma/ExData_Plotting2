###############  Question 2 ####################################
#   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#   from 1999 to 2008? Use the base plotting system to make a plot answering this question.
################################################################

# Load the data into memory.
   NEI <- readRDS("summarySCC_PM25.rds")
   SCC <- readRDS("Source_Classification_Code.rds")


# load the dplyr package to summarize the data.
  library("dplyr")

# Filter the NEI dataset to only include Baltimore City, Maryland
  baltimore <- NEI[NEI$fips == "24510",]

# Summarize the Baltimore NEI Emissions data by year 
  plot2Data <- summarize(group_by(baltimore,year), Emissions = sum(Emissions))


## Open the png device with a size of 480px by 480px
  png(file = "plot2.png",height = 480, width = 960)

## Set the frame size to include 1 row with 2 columns
  par(mfrow=c(1,2))

## Create a bar plot to visualize Emissions volumes by year
## Create a line plot to visualize the trend of Emissions volume over the years.
with(plot2Data, {
  
  barplot(plot2Data$Emissions, names = plot2Data$year,
          xlab="Year",ylab = "Total PM2.5 Emission", main="Baltimore City, MD - Yearly Emissions Levels", col = "blue")
  
  plot(x = year, y = Emissions, type = "l",xlab="Year", ylab = "Total PM2.5 Emission", main="Baltimore City, MD - Yearly Emissions Trend",col="blue")
})

## Close the png device to write the file.
dev.off()


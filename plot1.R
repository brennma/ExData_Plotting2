## This first line will likely take a few seconds. Be patient!


# Load the data into memory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

###############  Question 1 ####################################
#   1.  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#         Using the base plotting system, make a plot showing the total PM2.5 emission 
#         from all sources for each of the years 1999, 2002, 2005, and 2008.
################################################################

# load the dplyr package to summarize the data.
  library("dplyr")


# Summarize the NEI Emissions data by year
  plot1Data <- summarize(group_by(NEI,year), Emissions = sum(Emissions))


## Open the png device with a size of 480px by 480px
  png(file = "plot1.png",height = 480, width = 960)
## Set the frame size to include 1 row with 2 columns
  par(mfrow=c(1,2))
## Create a bar plot to visualize Emissions volumes by year
## Create a line plot to visualize the trend of Emissions volume over the years.

  with(plot1Data, {
      barplot(Emissions, names = year,
            xlab="Year",ylab = "Total PM2.5 Emission", main="Yearly Emissions Levels", col = "blue")
       plot(x = year, y = Emissions, type = "l",xlab="Year", ylab = "Total PM2.5 Emission", main="Yearly Emissions Trend", col="blue")
       })

## Close the png device to write the file.
  dev.off()


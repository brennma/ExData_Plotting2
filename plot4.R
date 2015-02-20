###############  Question 4 ####################################
#   Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
################################################################

# Load the data into memory.
   NEI <- readRDS("summarySCC_PM25.rds")
   SCC <- readRDS("Source_Classification_Code.rds")

#   load the dplyr package to summarize the data.
    library("dplyr")

#   Merge the NEI and SCC datasets to get the Emissions category information.
    NEISCC <- merge(x = NEI, y = SCC)

#   Filter the dataset to only include Emissions data associated to Coal fuel sources.
    
    combustFlag <- grep(pattern = "Combustion", x = NEISCC$SCC.Level.One)
    COALNEI <- NEISCC[combustFlag,]
    coalComb <- grep(pattern = "Coal", x = COALNEI$SCC.Level.Three)
    COALNEI <- COALNEI[coalComb,]

##  Summarize the dataset by year and Emissions
    plot4Data <- summarize(group_by(COALNEI, year), Emissions = sum(Emissions))


## Open the png device with a size of 480px by 480px
    png(file = "plot4.png",height = 480, width = 960)

## Set the frame size to include 1 row with 2 columns
    par(mfrow=c(1,2))
## Create the histogram of Global Active Power
    with(plot4Data, {
      
      barplot(Emissions, names = year,
              xlab="Year",ylab = "Coal PM2.5 Emission", main="US PM2.5 Emissions from Coal Combustion", col = "grey")
      
      plot(x = year, y = Emissions, type = "l",xlab="Year", ylab = "Coal PM2.5 Emission", main="US PM2.5 Emissions from Coal Combustion Trend",col="grey")
    })

## Close the png device to write the file.
    dev.off()

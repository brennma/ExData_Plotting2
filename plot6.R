###############  Question 6 ####################################
#   Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#   in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
################################################################

#   load the dplyr package to summarize the data.
    library("dplyr")

# Load the data into memory.
   NEI <- readRDS("summarySCC_PM25.rds")
   SCC <- readRDS("Source_Classification_Code.rds")

#   Merge the NEI and SCC datasets to get the Emissions category information.
    NEISCC <- merge(x = NEI, y = SCC)

#   Filter the dataset to only include emissions data associated to Vehicles
    vehicleFlag <- grepl(pattern = "Veh", x = NEISCC$Short.Name)
    vehicleNEISCC <- NEISCC[vehicleFlag == TRUE,]

#   Create a baltimore only dataset and summarize emissions by year
    baltVehicleNEI <- vehicleNEISCC[vehicleNEISCC$fips == "24510",]

    plot5Data <- summarize(group_by(baltVehicleNEI, year), Emissions = sum(Emissions))

#   Create a new column that contains the change in emissions from the previous year.  
#   For the first year, set the change to 0
    plot5Data[1,"annualEmissionsChange"] <- 0
    for(i in 2:nrow(plot5Data)){
      plot5Data[i,"annualEmissionsChange"] <- plot5Data[i,"Emissions"]-plot5Data[(i-1),"Emissions"]
      
    }

#   Create an LA County only dataset and summarize emissions by year
    LACountyVehicle <- vehicleNEISCC[vehicleNEISCC$fips == "06037",]

#   Create a new column that contains the change in emissions from the previous year.  
#   For the first year, set the change to 0
    plot6Data <- summarize(group_by(LACountyVehicle, year), Emissions = sum(Emissions))
    plot6Data[1,"LAEmissionsChange"] <- 0
    for(i in 2:nrow(plot6Data)){
      plot6Data[i,"LAEmissionsChange"] <- plot6Data[i,"Emissions"]-plot6Data[(i-1),"Emissions"]
    }


## Open the png device with a size of 480px by 480px
    png(file = "plot6.png",height = 960, width = 960)

## Set the panel layout to a 2 X 2 with LA Emissions on top and Baltimore Emissions on bottom
    par(mfrow=c(2,2))

## Create the 4 quadrant of plots of Vehicle Emissions, voltage, Sub metering for meters 1,2,3 and global reactive power

   

  plot(x = plot6Data$year, y = plot6Data$Emissions, type = "l",ylim = c(0,5000),xlab="Year", ylab = "Total PM2.5 Emission", main="Los Angeles County, CA Vehicle Emissions", col = "green")

  calbarchart <- barplot(plot6Data$LAEmissionsChange, ylim = c(-700,600), xlab="Year",ylab = "Total Change in PM2.5 Emission", main="Los Angeles County, CA Vehicle Emissions Change", col = "green")
  axis(1, at = calbarchart, labels = plot6Data$year)

  plot(x = plot5Data$year, y = plot5Data$Emissions, type = "l",ylim = c(0,5000),xlab="Year", ylab = "Total PM2.5 Emission", main="Baltimore City, MD Vehicle Emissions", col="blue")
  
  baltbarchart <- barplot(plot5Data$annualEmissionsChange, , ylim = c(-700,600), xlab="Year",ylab = "Total Change in PM2.5 Emission", main="Baltimore City, MD Vehicle Emissions Change", col="blue")
  axis(1, at = baltbarchart, labels = plot5Data$year)


## Close the png device to write the file.
dev.off()
###############  Question 5 ####################################
#   How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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

#   Create a dataset for only Baltimore, MD and summarize it by year
    baltVehicleNEI <- vehicleNEISCC[vehicleNEISCC$fips == "24510",]
    plot5Data <- summarize(group_by(baltVehicleNEI, year), Emissions = sum(Emissions))

## Open the png device with a size of 480px by 480px
    png(file = "plot5.png",height = 480, width = 480)

## Create the line plot showing baltimore vehicle emissions trend over the years

    with(plot5Data, {
      plot(x = year, y = Emissions, type = "l",xlab="Year", ylab = "Vehicle PM2.5 Emission", main="Baltimore City, MD Yearly Vehicle Emissions Trend",col="blue")
    })

## Close the png device to write the file.
    dev.off()
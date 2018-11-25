# Reading the file
library(data.table)
LoadedData <- fread("household_power_consumption.txt",
                    sep = ";",
                    header = TRUE,
                    colClasses = rep("character",9))

# Convert "?" in NAs
LoadedData[LoadedData == "?"] <- NA

# Selecting adequate lines
LoadedData$Date <- as.Date(LoadedData$Date, format = "%d/%m/%Y")
LoadedData <- LoadedData[LoadedData$Date >= as.Date("2007-02-01") & LoadedData$Date <= as.Date("2007-02-02"),]

# Convert column that we will use to correct class
LoadedData$Global_active_power <- as.numeric(LoadedData$Global_active_power)
# Constructing DateTime Vector
LoadedData$Date <- as.Date(LoadedData$Date, format="%d/%m/%Y")
dateTime <- paste(LoadedData$Date, LoadedData$Time)
LoadedData$DateTime <- as.POSIXct(dateTime)

# Do the graph
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(LoadedData$DateTime,LoadedData$Global_active_power,
     type="l",ylab = "Global Active Power (kilowatts)",xlab="")
dev.off()
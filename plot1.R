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

# Do the graph
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(LoadedData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
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
LoadedData$Voltage <- as.numeric(LoadedData$Voltage)
LoadedData$Sub_metering_1 <- as.numeric(LoadedData$Sub_metering_1)
LoadedData$Sub_metering_2 <- as.numeric(LoadedData$Sub_metering_2)
LoadedData$Sub_metering_3 <- as.numeric(LoadedData$Sub_metering_3)
# Constructing DateTime Vector
LoadedData$Date <- as.Date(LoadedData$Date, format="%d/%m/%Y")
dateTime <- paste(LoadedData$Date, LoadedData$Time)
LoadedData$DateTime <- as.POSIXct(dateTime)
LoadedData$Global_reactive_power <- as.numeric(LoadedData$Global_reactive_power)
# Do the graph
png(file = "plot4.png", width = 480, height = 480, units = "px", )
par(mfrow = c(2, 2))
# Graph 1
plot(LoadedData$DateTime,LoadedData$Global_active_power,
     type="l",ylab = "Global Active Power",xlab="")
# Graph 2
plot(LoadedData$DateTime,LoadedData$Voltage,
     type="l",ylab = "Voltage",xlab="datetime")
# Graph 3
plot(LoadedData$DateTime,LoadedData$Sub_metering_1, col="black",
     type="l",ylab = "Energy sub metering",xlab="")
lines(LoadedData$DateTime,LoadedData$Sub_metering_2, col="red",
      type="l",ylab = "Energy sub metering",xlab="")
lines(LoadedData$DateTime,LoadedData$Sub_metering_3, col="blue",
      type="l",ylab = "Energy sub metering",xlab="")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
# Graph 4
plot(LoadedData$DateTime,LoadedData$Global_reactive_power,
     type="l",ylab = "Global_reactive_power",xlab="datetime")
dev.off()
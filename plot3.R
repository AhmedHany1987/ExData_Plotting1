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
LoadedData$Sub_metering_1 <- as.numeric(LoadedData$Sub_metering_1)
LoadedData$Sub_metering_2 <- as.numeric(LoadedData$Sub_metering_2)
LoadedData$Sub_metering_3 <- as.numeric(LoadedData$Sub_metering_3)
# Constructing DateTime Vector
LoadedData$Date <- as.Date(LoadedData$Date, format="%d/%m/%Y")
dateTime <- paste(LoadedData$Date, LoadedData$Time)
LoadedData$DateTime <- as.POSIXct(dateTime)

# Do the graph
png(file = "plot3.png", width = 480, height = 480, units = "px", )
plot(LoadedData$DateTime,LoadedData$Sub_metering_1, col="black",
     type="l",ylab = "Energy sub metering",xlab="")
lines(LoadedData$DateTime,LoadedData$Sub_metering_2, col="red",
     type="l",ylab = "Energy sub metering",xlab="")
lines(LoadedData$DateTime,LoadedData$Sub_metering_3, col="blue",
     type="l",ylab = "Energy sub metering",xlab="")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
dev.off()
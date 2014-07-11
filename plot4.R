#load data in temporary file and then to variable called "data"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", colClasses = "character", header = TRUE)
unlink(temp)

# two strings for debugging
# setwd("D:/Work/EA")
# data <- read.table("household_power_consumption.txt", sep = ";"
#                     , colClasses = "character", header = TRUE)

# transform dates in dataframe to proper format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# extract only needed data (constrictions on the date)
chosenData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

#create variable with date and time
plotDatesAndTime <- as.POSIXct(paste(chosenData$Date,chosenData$Time), tz="GMT")

#apply English local time settings (for plot)
Sys.setlocale("LC_TIME", "English")

# constructing the plots and writing them to the file

#declare overall plot settings
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#first plot (from up to bottom and from left to right)
plot(x = plotDatesAndTime, y = chosenData$Global_active_power
     , type = "l", xlab = "", ylab = "Global active power(kilowatts)")

#second plot (from up to bottom and from left to right)
plot(x = plotDatesAndTime, y = chosenData$Voltage
     , type = "l", xlab = "datetime", ylab = "Voltage")

# third plot (from up to bottom and from left to right)
plot(x = plotDatesAndTime, y = chosenData$Sub_metering_1
     , type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = plotDatesAndTime, y = chosenData$Sub_metering_2, col = "red")
lines(x = plotDatesAndTime, y = chosenData$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = c(1,1,1))

#forth plot (from up to bottom and from left to right)
plot(x = plotDatesAndTime, y = chosenData$Global_reactive_power
     , type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()









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

# constructing the plot and writing it to the file

#declare overall settings
png(filename = "plot3.png", width = 480, height = 480)

# first part of the plot
plot(x = plotDatesAndTime, y = chosenData$Sub_metering_1
     , type = "l", xlab = "", ylab = "Energy sub metering")

# second part of the plot
lines(x = plotDatesAndTime, y = chosenData$Sub_metering_2, col = "red")

# third part of the plot
lines(x = plotDatesAndTime, y = chosenData$Sub_metering_3, col = "blue")

# and the final feature: the legend
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = c(1,1,1))

dev.off()









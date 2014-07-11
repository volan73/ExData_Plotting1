#load data in temporary file and then to variable called "data"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", colClasses = "character", header = TRUE)
unlink(temp)

# two strings for debugging
#setwd("D:/Work/EA")
#data <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE)

# transform dates in dataframe to proper format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# extract only needed data (constrictions on the date)
chosenData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

#transform format of Global_active_power to numeric
chosenData$Global_active_power <- as.numeric(chosenData$Global_active_power)

# constructing the plot and writing it to the file
png("plot1.png", width = 480, height = 480)
hist(temp2, col = "red", main = "Global active power", xlab = "Global active power(kilowatts)")
dev.off()
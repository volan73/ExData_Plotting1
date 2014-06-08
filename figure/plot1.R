fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", colClasses = "character", header = TRUE)
unlink(temp)

#setwd("D:/Work/EA")
#data <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#ind <- data[, 1] == "2007-02-01" | data[,1] == "2007-02-02"
data2 <- data[data[, 1] == "2007-02-01" | data[,1] == "2007-02-02", ]
h <- data2[3]
h2 <- as.numeric(h[,1])
png("plot1.png", width = 480, height = 480)
hist(h2, col = "red", main = "Global active power", xlab = "Global active power(kilowatts)")
dev.off()
library(lubridate)
library(data.table)

##downloading data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip("data.zip")

##laoding data
data <- fread("household_power_consumption.txt")

##converting to date
data$Date <- dmy(data$Date)

##main data

x <- data$Date
x <- year(x)==2007 & month(x)==2 & (day(x)==1 | day(x)==2)

data <- data[x==TRUE,]

##ploting data
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot1.png")
hist(data$Global_active_power,col="Red",xlab = "Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")

##cutting the connection
dev.off()

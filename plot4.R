library(lubridate)
library(data.table)
library(plyr)

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

data <- mutate(data , TimeStamp = strptime(paste(data$Date, data$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S "))
 png("plot4.png")
 par(mfrow = c(2,2))
 plot(data$TimeStamp,data$Global_active_power,xlab = "",ylab="Global Active Power",type="l")
 
 plot(data$TimeStamp,data$Voltage,xlab = "datetime",ylab="Voltage",type="l")
 
 plot(data$TimeStamp,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
 points(data$TimeStamp,data$Sub_metering_2,type="l",col="red")
 points(data$TimeStamp,data$Sub_metering_3,type="l",col="blue")
 
 plot(data$TimeStamp,data$Global_reactive_power,xlab = "datetime",ylab="Global_reactive_power",type="l")
 
 dev.off()
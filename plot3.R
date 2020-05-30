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
png("plot3.png")
data <- mutate(data , TimeStamp = strptime(paste(data$Date, data$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S "))

plot(data$TimeStamp,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
points(data$TimeStamp,data$Sub_metering_2,type="l",col="red")
points(data$TimeStamp,data$Sub_metering_3,type="l",col="blue")

##adding legend

legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()
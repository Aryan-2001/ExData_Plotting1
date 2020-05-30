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
png("plot2.png")
plot(data$TimeStamp,data$Global_active_power,xlab = "",ylab="Global Active Power(kilowatts)",type="l")
dev.off()


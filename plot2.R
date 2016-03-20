
##Plot2.R
#Developed to mimic the example provided in Coursera 

#Loading libraries
library(data.table)
library(dplyr)

# Loading the files
zipf <- unzip(paste0(getwd(), "/exdata_data_household_power_consumption.zip"))
hdata <- data.table(read.csv2(zipf,na.strings = "?", stringsAsFactors = FALSE))

#Setting Date as Date
hdata$Date <- as.Date(hdata$Date, "%d/%m/%Y")

#Setting the time interval (2 days in February, 2007)
d1 <- as.Date("01/02/2007", "%d/%m/%Y")
d2 <- as.Date("02/02/2007", "%d/%m/%Y")

#Filtering the time interval
hdata <- filter(hdata, Date >= d1 & Date <= d2)

#Getting two columns data
z <- paste(hdata$Date, hdata$Time)
z <- strptime(z, "%Y-%m-%d %H:%M:%S")

#Adjusting the data to numeric
hdata$Global_active_power <- as.numeric(hdata$Global_active_power)

#Starting a new plot - in a new device
png(file = "plot2.png")

#Creating a empty plot
plot(z,hdata$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power (kilowatts)", main = "")

#Doing the real plot
lines(z,hdata$Global_active_power)

dev.off()

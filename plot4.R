
##Plot3.R
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
hdata$Voltage <- as.numeric(hdata$Voltage)
hdata$Global_reactive_power <- as.numeric(hdata$Global_reactive_power)
hdata$Sub_metering_1 <- as.numeric(hdata$Sub_metering_1)
hdata$Sub_metering_2 <- as.numeric(hdata$Sub_metering_2)
hdata$Sub_metering_3 <- as.numeric(hdata$Sub_metering_3)

#Starting a new plot - in a new device
#Four plots!!
png(file = "plot4.png")
par(mfrow = c(2,2))

##First Plot
plot(z, hdata$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power", main = "")
lines(z, hdata$Global_active_power)

##Second Plot
plot(z, hdata$Voltage, type = "n",
     xlab = "datetime", ylab = "Voltage", main = "")
lines(z, hdata$Voltage)


##Third Plot
plot(z,hdata$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering", main = "")

lines(z, hdata$Sub_metering_1, col = 1)
lines(z, hdata$Sub_metering_2, col = 2)
lines(z, hdata$Sub_metering_3, col = 4)

legend("topright", lty = 1, col = c(1, 2, 4),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

##Fourth Plot
#I think they forget to remove the underscores in the "ylab"
#So, I correct it myself, just pointint it
plot(z, hdata$Global_reactive_power, type = "n",
     xlab = "datetime", ylab = "Global reactive power", main = "")
lines(z, hdata$Global_reactive_power)

##Saving it to a png file
dev.off()

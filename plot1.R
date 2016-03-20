
##Plot1.R
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

#Now we have 48 hours (2 days) of date
#Convert the character values in numeric ones
hdata$Global_active_power <- as.numeric(hdata$Global_active_power)

#Building the histogram - in a new device
png(file = "plot1.png")
hist(hdata$Global_active_power,
     col = 2,
     xlab = "Global active power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active power")


#Writting a PNG file of that
dev.off()


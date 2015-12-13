## Script to generate plot 3 of course project 1
## Exploratory Data Analysis 
##
##Importing the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./power_consumption.zip",method="curl")
unzip("power_consumption.zip")

# Reading dataset
power_c <- read.csv("household_power_consumption.txt")

#Initializing Tidyr Library
library(tidyr)

# Split columns in dataset
power_c2 <- separate(power_c, 'Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3', paste("var", 1:9, sep = "_"), sep = ";", extra = "drop")

# Rename columns in dataset
colnames(power_c2) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# subsetting by specific dates
power_cf1 <- subset(power_c2, grepl("^1/2/2007", power_c2$Date))
power_cf2 <- subset(power_c2, grepl("^2/2/2007", power_c2$Date))
power_cf <- rbind(power_cf1, power_cf2) 

# Specifying the types of variables
#power_cf$Date <- as.Date(power_cf$Date)
#power_cf$Time <- strptime(power_cf$Time, "%hh:%mm:%ss")
power_cf$Global_active_power <- as.numeric(power_cf$Global_active_power)
power_cf$Global_reactive_power <- as.numeric(power_cf$Global_reactive_power)
power_cf$Voltage <- as.numeric(power_cf$Voltage)
power_cf$Global_intensity <- as.numeric(power_cf$Global_intensity)
power_cf$Sub_metering_1 <- as.numeric(power_cf$Sub_metering_1)
power_cf$Sub_metering_2 <- as.numeric(power_cf$Sub_metering_2)
power_cf$Sub_metering_2 <- as.numeric(power_cf$Sub_metering_2)
power_cf$Sub_metering_3 <- as.numeric(power_cf$Sub_metering_3)
# Making the plot
# font size
par(cex.main = 0.85) # title
par(cex.lab = 0.65) # labels x,y
par(cex.axis = 0.75) # axis

# Setting my R for English 
Sys.setlocale("LC_ALL", 'en_US.UTF-8')

# Using lubridate to work with Date and Time
library(lubridate)

dt <- dmy_hms(paste(power_cf$Date, power_cf$Time))

plot(dt, power_cf$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type='l')
points(dt, power_cf$Sub_metering_2, ylab = "Energy sub metering", xlab = "", type='l', col = "red")
points(dt, power_cf$Sub_metering_3, ylab = "Energy sub metering", xlab = "", type='l', col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1.5, y.intersp = 0.9, cex = .7, adj = .1)

# Saving the plot in .png format

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

## the end

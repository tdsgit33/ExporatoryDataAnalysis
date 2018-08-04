if (!file.exists("exdata_data_household_power_consumption")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Dataset.zip")
  unzip("Dataset.zip")
} else {
  print("File already downloaded.")
}

if (!"sqldf" %in% installed.packages()) install.packages("sqldf")
library(sqldf)

# Save the filename
fn <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
# Read in only the data with the appropriate dates
edata <- read.csv.sql(fn, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

#Build a datetime column
edata$DateTime <- ymd_hms(paste(dmy(edata$Date), edata$Time))

# Open the png device
png(file="plot4.png",width=480, height=480)

# Set up a 2x2 matrix to place graphs
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Chart1 (Plot2)
plot(edata$DateTime, edata$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "n")
lines(edata$DateTime, edata$Global_active_power)

# Chart2 (Plot3)
plot(edata$DateTime, edata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(edata$DateTime, edata$Sub_metering_2, col = "red")
lines(edata$DateTime, edata$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

# Chart3
plot(edata$DateTime, edata$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(edata$DateTime, edata$Voltage)

# Chart4
plot(edata$DateTime, edata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(edata$DateTime, edata$Global_reactive_power)


dev.off()


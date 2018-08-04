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
# Read in only the records from the appropriate days
edata <- read.csv.sql(fn, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

# Build a datetime column
edata$DateTime <- ymd_hms(paste(dmy(edata$Date), edata$Time))

# Open the png device
png(file="plot3.png",width=480, height=480)

# Build the chart
plot(edata$DateTime, edata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(edata$DateTime, edata$Sub_metering_2, col = "red")
lines(edata$DateTime, edata$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

dev.off()


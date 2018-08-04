if (!file.exists("exdata_data_household_power_consumption")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Dataset.zip")
  unzip("Dataset.zip")
} else {
  print("File already downloaded.")
}

if (!"sqldf" %in% installed.packages()) install.packages("sqldf")
library(sqldf)

# Read the data file
fn <- "./exdata_data_household_power_consumption/household_power_consumption.txt"

# Read in only the records from the appropriate dates
edata <- read.csv.sql(fn, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

# Build a datetime column
edata$DateTime <- ymd_hms(paste(dmy(edata$Date), edata$Time))

# Open the png device
png(file="plot2.png",width=480, height=480)

# Build the graph
plot(edata$DateTime, edata$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "n")
lines(edata$DateTime, edata$Global_active_power)

dev.off()


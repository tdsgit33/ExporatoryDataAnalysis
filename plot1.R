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
# Read in only the records from the appropriate dates
edata <- read.csv.sql(fn, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

# Build the chart
png(file="plot1.png",width=480, height=480)
hist(edata$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col ="red")

dev.off()


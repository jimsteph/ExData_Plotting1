################################################################################
# Exploratory Data Analysis
# Week 1 Project, part 1
# 2014-07-13
#
# This program reads downloads and imports a file on household power 
# consumption, slices out two specific dates, then creates a PNG file with a 
# specific plot based on the data:
#   * Part 1 is a histogram of Global Active Power
#   * Part 2 is a line graph of Global Active Power
#   * Part 3 is a line graph showing all three Sub Metering values
#   * Part 4 is a grid of four line graphs: Global Active Power, Voltage,
#     Sub Metering, and Global Reactive Power
################################################################################

# Download and unzip the file.  These four lines are commented out as they only
# need to be run once for all four plots.
#if (!file.exists("./data")) {dir.create("./data")}
#fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileURL, destfile = "./data/dataset.zip", method = "curl", mode = "wb")
#unzip("./data/dataset.zip", exdir = "./data")

# Read in the data
fileName <- "./data/household_power_consumption.txt"
hpc <- read.csv2(fileName, 
                 header = TRUE, 
                 colClasses = c("character", "character", rep("numeric", 7)), 
                 na.strings = "?",
                 dec = ".")
hpc[, 1] <- as.Date(hpc[, 1], format="%d/%m/%Y")
# Limit it to the two dates required for the project
hpc.selected <- hpc[hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02", ]
# Convert the date and time to a combined date-time field
hpc.selected$DateTime <- strptime(paste(as.character(hpc.selected$Date), 
                                        hpc.selected$Time), 
                                  format = "%Y-%m-%d %H:%M:%S")

# Plot a histogram of the Global Active Power and save it as a png file
png(filename = "./plot1.png", width = 480, height = 480, units = "px")
par(bg = "transparent")
hist(hpc.selected$Global_active_power, 
     freq = TRUE, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency",
     main = "Global Active Power", 
     col = "Red")
dev.off()

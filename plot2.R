## Week 1 assignment plot 2
# read the data from the working directory
# read the column classes first to accelerate the reading
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep=";",na.strings = "?", nrows = 5)
classes <- sapply(tab5rows, class)
# read all data
allData <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes, sep=";",na.strings = "?",stringsAsFactors=FALSE)
# create a new column with the merge or date and time
allData$DateTime <- as.POSIXct(paste(allData$Date, allData$Time),format = "%d/%m/%Y %H:%M:%S")

library(dplyr)
# filter between the specific days in February on the 2007
desiredData <- filter(allData, DateTime >= as.POSIXct("2007-02-01 00:00:00"), DateTime < as.POSIXct("2007-02-03 00:00:00"))
# remove the extra columns
desiredData <- select(desiredData,Global_active_power:DateTime)

# generate the png file with a width of 480 pixels and a height of 480 pixels
png("plot2.png", width = 480, height = 480)
# create the graphic
with(desiredData,plot(DateTime,Global_active_power,ylab = "Global Active Power (kilowatts)", xlab="", type = "l"))
# close the png file
dev.off()
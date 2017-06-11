# Week 1 assignment plot 4

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
png("plot4.png", width = 480, height = 480)
# create the graphic
par(mfcol=c(2,2)) # column wise
# first graphic
with(desiredData,plot(DateTime,Global_active_power,ylab = "Global Active Power (kilowatts)", xlab="", type = "l"))
# second graphic
with(desiredData,{
    plot(DateTime,Sub_metering_1,ylab = "Energy sub metering", xlab="",type = "l")
    lines(DateTime,Sub_metering_2, col= "red",type = "l")
    lines(DateTime,Sub_metering_3, col= "blue",type = "l")
})
legend("topright",
       lty=c(1,1,1), 
       col=c("black","red","blue"), cex = 0.8,bty = "n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# third graphic
with(desiredData,plot(DateTime,Voltage, ylab="Voltage",xlab="datetime",type="l"))

# fourth graphic
with(desiredData,plot(DateTime,Global_reactive_power,ylab="Global_reactive_power",xlab = "datetime",type="l"))
# close the png file
dev.off()
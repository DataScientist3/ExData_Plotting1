library(lubridate)
# Read data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, na.strings = "?")

# Select only interesting dates
data$When <- dmy_hms(paste(data$Date, data$Time, sep=" "))
data <- data[data$When %within% (dmy_hms("1/2/2007 00:00:00") %--% dmy_hms("2/2/2007 23:59:59")) ,]

# Plot lines
png("plot2.png")
y <- data$Global_active_power
x <- data$When

plot(x, y, ylab="Global Active Power (kilowatts)", type="n")
lines(x, y)
dev.off()
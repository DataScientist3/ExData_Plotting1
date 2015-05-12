library(lubridate)
# Read data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, na.strings = "?")

# Select only interesting dates
data$When <- dmy_hms(paste(data$Date, data$Time, sep=" "))
data <- data[data$When %within% (dmy_hms("1/2/2007 00:00:00") %--% dmy_hms("2/2/2007 23:59:59")) ,]

# From top to bottom, left to right
png("plot4.png")
par(mfrow=c(2, 2))

# Global Active Power vs Date
y <- data$Global_active_power
x <- data$When

plot(x, y, ylab="Global Active Power", type="n")
lines(x, y)

# Voltage versus date
y <- data$Voltage
x <- data$When

plot(x, y, ylab="Voltage", type="n", xlab = "datetime")
lines(x, y)

# Energy sub metering
y1 <- data$Sub_metering_1
y2 <- data$Sub_metering_2
y3 <- data$Sub_metering_3

x <- data$When

plot(x, y1, ylab="Energy sub metering", type="n")
lines(x, y1, col = "black")
lines(x, y2, col = "red")
lines(x, y3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

# Global Reactive Power vs datetime
y <- data$Global_reactive_power
x <- data$When

plot(x, y, ylab="Global_reactive_power", type="n", xlab = "datetime")
lines(x, y)
dev.off()
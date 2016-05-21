#Plot4

## Getting full dataset
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# First
plot(data$Global_active_power ~ data$Datetime, ylab="Global Active Power", type="l", xlab="")

# Second
plot(data$Voltage ~ data$Datetime, ylab="Voltage", type="l", xlab="datetime")

# Third
plot(data$Sub_metering_1~data$Datetime, ylab="Engergy sub metering", xlab="", type="l")
lines(data$Sub_metering_2~data$Datetime, col="Red")
lines(data$Sub_metering_3~data$Datetime, col="Blue")
legend("topright", legend=c("Sub_metering_1   ", "Sub_metering_2   ", "Sub_metering_3   "), col=c("Black", "Red", "Blue"), lty=1, lwd=2, cex = 0.7, bty="n")

# Fourth
plot(data$Global_reactive_power~data$Datetime, type="l", ylab="Global Reactive Power", xlab="datetime")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
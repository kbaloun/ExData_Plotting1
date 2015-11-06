poweruse <- read.table("./household_power_consumption.txt", header=TRUE, sep=";")

poweruse$DateAsDate <- as.Date(poweruse$Date,"%d/%m/%Y")
poweruse$TimeAsTime <- strptime(poweruse$Time,"%H:%M:%S")
d2 <- subset(poweruse, DateAsDate=="2007-02-02")
d1 <- subset(poweruse, DateAsDate=="2007-02-01")
target <- combine(d1,d2)
target$srcDateAndTime <- paste(target$Date, target$Time)
target$DateAndTime <- strptime(target$srcDateAndTime,"%d/%m/%Y %H:%M:%S")

par(mfrow = c(2,2), mfcol = c(2,2), mar=c(4,4,2,1), oma=c(1,1,1,1), cra=8)

with(target, {
    par(oma=c(1,1,1,1))
    plot(target$DateAndTime,target$Global_active_power, type="n", xlab="", ylab="Global Active Power")
    lines(target$DateAndTime,target$Global_active_power)
    
    plot(target$DateAndTime, target$Sub_metering_1, type="n", xlab="", ylab="Energy Sub metering")
    legend("topright", bty="n", lty=1, col = c("grey","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    par(col = 'black')
    lines(target$DateAndTime, target$Sub_metering_1)
    par(col = 'red')
    lines(target$DateAndTime, target$Sub_metering_2)
    par(col = 'blue')
    lines(target$DateAndTime, target$Sub_metering_3)
    par(ylog=TRUE)


    par(col = 'black')
    plot(target$DateAndTime, target$Voltage, type="n", xlab="datetime", ylab="Voltage")
    lines(target$DateAndTime, target$Voltage)

    plot(target$DateAndTime, target$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
    lines(target$DateAndTime, target$Global_reactive_power)
    par(ylog=TRUE)
})
par(op)

dev.copy(png, file = "./plot4.png")
dev.off()

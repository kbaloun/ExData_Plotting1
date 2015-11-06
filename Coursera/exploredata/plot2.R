poweruse <- read.table("./household_power_consumption.txt", header=TRUE, sep=";")


poweruse$DateAsDate <- as.Date(poweruse$Date,"%d/%m/%Y")
poweruse$TimeAsTime <- strptime(poweruse$Time,"%H:%M:%S")
d2 <- subset(poweruse, DateAsDate=="2007-02-02")
d1 <- subset(poweruse, DateAsDate=="2007-02-01")
target <- combine(d1,d2)

target$srcDateAndTime <- paste(target$Date, target$Time)
target$DateAndTime <- strptime(srcDateAndTime,"%d/%m/%Y %H:%M:%S")
plot(target$DateAndTime,target$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(target$DateAndTime,target$Global_active_power)

dev.copy(png, file = "./plot2.png")
dev.off()

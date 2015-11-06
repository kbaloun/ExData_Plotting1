poweruse <- read.table("./household_power_consumption.txt", header=TRUE, sep=";")

poweruse$DateAsDate <- as.Date(poweruse$Date,"%d/%m/%Y")
poweruse$TimeAsTime <- strptime(poweruse$Time,"%H:%M:%S")
d2 <- subset(poweruse, DateAsDate=="2007-02-02")
d1 <- subset(poweruse, DateAsDate=="2007-02-01")
target <- combine(d1,d2)

hist(target$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "./plot1.png")
dev.off()

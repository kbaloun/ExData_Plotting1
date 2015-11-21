## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
head(NEI)

#Q1
NEI$EmissionsAsNumeric <- as.numeric(NEI$Emissions)
#aggregate(flow ~ cut(date, "1 year")
#aggregate(NEI$Emissions ~ cut(NEI$yearAsDate), "1 year")
#Error in eval(predvars, data, env) : 
#    invalid 'envir' argument of type 'character'

sum1999 <- sum(NEI$year == 1999, NEI$EmissionsAsNumeric)
sum2002 <- sum(NEI$year == 2002, NEI$EmissionsAsNumeric)
sum2005 <- sum(NEI$year == 2005, NEI$EmissionsAsNumeric)
sum2008 <- sum(NEI$year == 2008, NEI$EmissionsAsNumeric)

emissions <- c(sum1999,sum2002,sum2005,sum2008)
n <- c(1999,2002,2005,2008)
q1 <- data.frame(as.character(n), as.numeric(emissions))
plot(q1, xlab="Year", ylab="2.5PM Emissions", main="Total US Emissions by Year")

#Q2
baltimore <- NEI[NEI$fips == "24510",]
factor(baltimore$year)

as.numeric(baltimore$Emissions)
# choosing data.table, as usually faster than plyr
baldt <- data.table(baltimore, keep.rownames = TRUE)
setkey(baldt, rn)
factor(baldt$year, levels=c(1999,2002,2005,2008))
baldt[,sum(Emissions), by="year"]
q2 <- q2[order(year)]
plot(q2, xlab="Year", ylab="2.5PM Emissions", main="Total Baltimore Emissions by Year")

library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
factor(baldt$type)
q3 <- baldt[,sum(Emissions), by="year,type"]
q3 <- q3[order(year,type)]
qplot(year, V1 , data=q3, geom="line", color=type, ylab="Emissions", main="Baltimore Emissions by Year and Type")

#q4
sccdt <- data.table(SCC)
coalscc <- sccdt[like(Short.Name,"Coal"),SCC]
CoalNEI <- subset(NEI, SCC==coalscc)
CoalDt <- data.table(CoalNEI)
q4 <- CoalDt[,sum(Emissions), by="year"]
qplot(year, V1 , data=q4, geom="line", ylab="Emissions", main="US Emissions For Coal by Year and Type")

#ignoring the 9 charcoal related factors, if "coal" is lower case
#coalscc is a Large factor of 230 elements

#q5
# taking motor vehicle traffic as the "type" = "ON-ROAD"
balmotordt <- baldt[baldt$type=="ON-ROAD",]
q5 <- balmotordt[,sum(Emissions), by="year"]
qplot(year, V1 , data=q5, geom="line", ylab="Emissions", main="Motor Vehicle Emissions for Baltimore")

#q6, LA = fips == 06037
balNla <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]
bNlaDt <- data.table(balNla)
blMotorDt <- bNlaDt[bNlaDt$type=="ON-ROAD",]
q6 <- blMotorDt[,sum(Emissions), by="year,fips"]
q6$fips[c(1,4,6,7)] = "Baltimore"
q6$fips[c(2,3,5,8)] = "Los Angeles"
qplot(year, V1 , data=q6, geom="line", color=fips, ylab="Emissions", main="Motor Vehicle Emissions, Baltimore vs Los Angeles")

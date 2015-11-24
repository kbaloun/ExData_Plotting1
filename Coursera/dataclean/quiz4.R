us <- read.csv("getdata_data_ss06hid.csv")
q1 <- strsplit(names(us), "wgtp")

gdp <- read.csv("getdata_data_GDP.csv")
gdp <- gdp[5:194,]
q2 <- gsub(",","",gdp$X.3)
mean(as.numeric(q2))
#[1] 377652.4

#3
grep("^United",gdp$X.2)
#[1]  1  6 32

#4
library("data.table")
gdp <- read.csv("getdata_data_GDP.csv")
ed <- read.csv("getdata_data_EDSTATS_Country.csv")
gdp <- data.table(gdp)
ed <- data.table(ed)
gdp$X <- as.character(gdp$X) 
ed$CountryCode <- as.character(ed$CountryCode) 
gdp <- gdp[5:194,]
setkey(ed,CountryCode)
setkey(gdp,X)
countries <- merge(gdp,ed,by.x="X",by.y="CountryCode")
grep("Fiscal year end: June",ed$Special.Notes)
#[1]  11  18  31  60  76 105 112 166 173 188 199 216 234

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
q5 <- format(sampleTimes,"%Y %a")
grep("2012",q5)
grep("2012 Mon",q5)
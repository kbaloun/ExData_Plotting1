us <- read.csv("getdata_data_ss06hid.csv")
us$agricultureLogical <- ifelse(us$AGS=="6" & us$ACR == "3", TRUE, FALSE)


install.packages("jpeg")
jeff <- readJPEG("getdata_jeff.jpg", native=TRUE)
quantile(jeff, probs = c(0.3,0.8))

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
#countries$Gross.domestic.product.2012 <- as.numeric(countries$Gross.domestic.product.2012)
# ^_ that somehow suffles the values
countries$gdp <- as.numeric(as.character(countries$Gross.domestic.product.2012))
countries <- arrange(countries,gdp)

countries[Income.Group=="High income: OECD", mean(gdp)]
countries[Income.Group=="High income: nonOECD", mean(gdp)]

countries$cutIncome <- cut(countries$gdp, breaks=5)
table(countries$Income.Group, countries$cutIncome)

lmc <- countries[countries$Income.Group == "Lower middle income",]
lmc[,cutIncome,Long.Name]
